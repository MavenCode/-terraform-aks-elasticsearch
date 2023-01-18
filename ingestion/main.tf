module "elasticsearch_setup" {
  source = "github.com/MavenCode/terraform-aks-elasticsearch.git"

  virtual_network_name      = var.virtual_network_name
  resource_group_location   = var.resource_group_location
  resource_group_name       = var.resource_group_name
  subnet_name               = var.subnet_name
  public_ip_name            = var.public_ip_name
  domain_name_label         = var.domain_name_label
  environment               = var.environment
  network_interface_name    = var.network_interface_name
  storage_account_name      = var.storage_account_name
  storage_container_name    = var.storage_container_name
  vm_name                   = var.vm_name
  disk_name                 = var.disk_name
  computer_name             = var.computer_name
  admin_username            = var.admin_username
  admin_password            = var.admin_password
  security_group_name       = var.security_group_name
}