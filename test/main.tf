# create virtual network
resource "azurerm_virtual_network" "vnet" {
    name                = var.virtual_network_name
    address_space       = ["10.0.0.0/16"]
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name
}

# create subnet
resource "azurerm_subnet" "subnet" {
    name                    = var.subnet_name
    resource_group_name     = var.resource_group_name
    virtual_network_name    = "${azurerm_virtual_network.vnet.name}"
    address_prefixes        = ["10.0.2.0/24"]
}

# create public IPs
resource "azurerm_public_ip" "ip" {
    name = var.publics_ip_name
    location = var.resource_group_location
    resource_group_name = var.resource_group_name
    allocation_method = "Static"
    domain_name_label = var.domain_name_label

    tags = {
        environment = var.environment
    }
}

data "azurerm_public_ip" "ip" {
    name = azurerm_public_ip.ip.name
    resource_group_name = var.resource_group_name
}


# create network interface
resource "azurerm_network_interface" "network" {
    name = var.network_interface_name
    location = var.resource_group_location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name = "ipconfiguration"
        subnet_id = "${azurerm_subnet.subnet.id}"
        private_ip_address_allocation = "Static"
        private_ip_address = "10.0.2.5"
        public_ip_address_id = "${azurerm_public_ip.ip.id}"
    }
}


# create storage account
resource "azurerm_storage_account" "storage" {
    name = var.storage_account_name
    resource_group_name = var.resource_group_name
    location = var.resource_group_location
    account_tier = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = var.environment
    }
}


# create storage container
resource "azurerm_storage_container" "storage" {
    name = var.storage_container_name
    storage_account_name = "${azurerm_storage_account.storage.name}"
    container_access_type = "private"
    depends_on = [azurerm_storage_account.storage]
}

# create private key
resource "tls_private_key" "docai_ssh" {
    algorithm = "RSA"
    rsa_bits = 4096
}

# create security group
resource "azurerm_network_security_group" "docai_sg" {
  name                = var.security_group_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "port-80"
    priority                   = 310
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ElasticSearch-9200"
    priority                   = 320
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "9200"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ElasticSearch-9300"
    priority                   = 330
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "9300"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Kibana-5601"
    priority                   = 340
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "5601"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_interface_security_group_association" "docai_net_association" {
  network_interface_id      = azurerm_network_interface.network.id
  network_security_group_id = azurerm_network_security_group.docai_sg.id
}

# create virtual machine
resource "azurerm_virtual_machine" "elasticsearch_vm" {
    name = var.vm_name
    location = var.resource_group_location
    resource_group_name = var.resource_group_name
    network_interface_ids = ["${azurerm_network_interface.network.id}"]
    vm_size = "Standard_E2s_v3"

    storage_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "16.04-LTS"
        version = "latest"
    }

    storage_os_disk {
        name = var.disk_name
        caching = "ReadWrite"
        managed_disk_type = "Standard_LRS"
        create_option = "FromImage"
    }

    os_profile {
        computer_name   = var.computer_name
        admin_username  = var.admin_username
        admin_password  = var.admin_password
    }

    os_profile_linux_config {
      disable_password_authentication = true
      
      ssh_keys {
        key_data = tls_private_key.docai_ssh.public_key_openssh
        path = "/home/${var.admin_username}/.ssh/authorized_keys"
    }
    }

    delete_os_disk_on_termination = true
    delete_data_disks_on_termination = true

    connection {
        host = "${var.domain_name_label}.${var.resource_group_location}.cloudapp.azure.com"
        user = var.admin_username
        type = "ssh"
        private_key = tls_private_key.docai_ssh.private_key_openssh
        timeout = "1m"
        agent = false
        }

    provisioner "file" {
        // content     = templatefile("elasticsearch.yml", { host = data.azurerm_public_ip.ip.ip_address })
        source      = "elasticsearch.yml"
        destination = "/tmp/elasticsearch.yml"
    }

    provisioner "file" {
        // content     = templatefile("kibana.yml", { host = data.azurerm_public_ip.ip.ip_address })
        source      = "kibana.yml"
        destination = "/tmp/kibana.yml"
    }

    provisioner "remote-exec" {

        inline = [
          "sudo apt-get update && sudo apt-get install openjdk-8 -y",
          "wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -",
          "sudo apt-get install apt-transport-https -y",
          "echo 'deb https://artifacts.elastic.co/packages/7.x/apt stable main' | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list",
          "sudo apt-get update",
          "sudo apt-get install elasticsearch -y && sudo apt-get install kibana -y && sudo apt-get install logstash",
          "sudo mv /tmp/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml",
          "sudo mv /tmp/kibana.yml /etc/kibana/kibana.yml",
          "sudo systemctl start elasticsearch && sudo systemctl start kibana",
          "sudo systemctl enable elasticsearch && sudo systemctl enable kibana"
        ]
    }

    tags = {
        environment = var.environment
    }
}