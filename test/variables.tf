variable "virtual_network_name" {
    type = string
    default = "es_vm_network"
}

variable "resource_group_location" {
    type = string
    default = "canadacentral"
}

variable "resource_group_name" {
    type = string
    default = "BMA-nlp-infra"
}

variable "subnet_name" {
    type = string
    default = "es_vm_subnet"
}

variable "publics_ip_name" {
    type = string
    default = "es_vm_ip"
}

variable "domain_name_label" {
    type = string
    default = "docai-es"
}

variable "environment" {
    type = string
    default = "dev"
}

variable "network_interface_name" {
    type = string
    default = "es_vm_interface"
}

variable "storage_account_name" {
    type = string
    default = "docaivmstorage"
}

variable "storage_container_name" {
    type = string
    default = "es-vm-container"
}

variable "vm_name" {
    type = string
    default = "es-vm"
}

variable "disk_name" {
    type = string
    default = "es_vm_disk"
}

variable "computer_name" {
    type = string
    default = "docai-es-vm"
}

variable "admin_username" {
    type = string
    default = "docai_vm_user"
}

variable "admin_password" {
    type = string
    default = "Docai#234pass"
}

variable "azure_subscription_id" {
    type = string
    default = "88f8e67a-c798-4b94-b332-XXXXX"
}

variable "azure_client_id" {
    type = string
    default = "e71a36ca-659a-4c30-aa96-XXXXX"
}

variable "azure_client_secret" {
    type = string
    default = "XANCbsy~Cx3gpmGityjxcM_XXXXX"
}

variable "azure_tenant_id" {
    type = string
    default = "8d6b80b7-89b2-4ee9-8726-XXXXX"
}

variable "security_group_name" {
    type = string
    default = "docai_sec_group"
}