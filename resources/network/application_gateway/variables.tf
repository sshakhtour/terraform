###
# resource variables
###

#common
variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "environment" {
  description = "Development environment for resource; prod, non-prod, shared-services"
  type        = string
}

variable "workload" {
  description = "The name of workload"
  type        = string
  default     = "atlp"
}

variable "region" {
  description = "Geographic region resource will be deployed into"
  type        = string
}

variable "vnet_name" {
  description = "the vnet name"
  type        = string
  default = ""
}

variable "subnet_id" {
  description = "Subnet Id"
  type        = string
}

variable "public_ip_address_id" {
  description = "Id of the public ip"
  type        = string
}

#tags
variable "tags" {
  description = "Optional tags to be added to resource"
  type        = map
  default     = {}
}