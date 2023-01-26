module "elasticsearch_setup" {
  source = "github.com/MavenCode/terraform-aks-elasticsearch.git"

  name                      = var.name
  resource_group_location   = var.resource_group_location
  resource_group_name       = var.resource_group_name
  vm_size                   = var.vm_size
  disk_type                 = var.disk_type
  environment               = var.environment
  es_cluster_name           = var.es_cluster_name
  es_node_name              = var.es_node_name
  es_network_host           = var.es_network_host
  es_discovery_type         = var.es_discovery_type
  kibana_host               = var.kibana_host
  kibana_server_name        = var.kibana_server_name
  kibana_es_hosts           = var.kibana_es_hosts
}