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