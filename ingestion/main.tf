module "elasticsearch_setup" {
  source = "github.com/MavenCode/terraform-aks-elasticsearch.git"

  name                      = var.name
  resource_group_location   = var.resource_group_location
  resource_group_name       = var.resource_group_name
  environment               = var.environment
}