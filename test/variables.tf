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

variable "disk_size" {
    type = string
    default = "Standard_LRS"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "azure_subscription_id" {
    type = string
}

variable "azure_client_id" {
    type = string
}

variable "azure_client_secret" {
    type = string
}

variable "azure_tenant_id" {
    type = string
}