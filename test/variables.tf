variable "resource_group_location" {
    type = string
    default = "canadacentral"
}

variable "resource_group_name" {
    type = string
    default = "BMA-nlp-infra"
}

variable "name" {
    type = string
    default = "docai-es"
}

variable "vm_size" {
    type = string
    default = "Standard_E2s_v3"
}

variable "disk_type" {
    type = string
    default = "Standard_LRS"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "azure_subscription_id" {
    type = string
    default = "88f8e67a-c798-4b94-b332-XXXXXXX"
}

variable "azure_client_id" {
    type = string
    default = "e71a36ca-659a-4c30-aa96-XXXXXXX"
}

variable "azure_client_secret" {
    type = string
    default = "XANCbsy~Cx3gpmGityjxcM_XXXXXXXX"
}

variable "azure_tenant_id" {
    type = string
    default = "8d6b80b7-89b2-4ee9-8726-XXXXXXXXX"
}

variable "es_cluster_name" {
    type = string
    default = "docai-es-cluster"
}

variable "es_node_name" {
    type = string
    default = "docai-es-node"
}

variable "es_network_host" {
    type = string
    default = "0.0.0.0"
}

variable "es_discovery_type" {
    type = string
    default = "single-node"
}

variable "kibana_host" {
    type = string
    default = "0.0.0.0"
}

variable "kibana_server_name" {
    type = string
    default = "elasticsearch-server"
}

variable "kibana_es_hosts" {
    type = string
    default = "['http://localhost:9200']"
}