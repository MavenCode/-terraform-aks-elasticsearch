output "elasticsearch_host" {
    value = "http://${data.azurerm_public_ip.ip.ip_address}:5601"
}