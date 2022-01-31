variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault"
}

variable "environment" {
  description = "Development environment for resource; prod, non-prod, shared-services"
  type        = string
}

variable "region" {
  description = "Geographic Region resource will be deployed into"
  type        = string
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map
  default     = {}
}

variable "workload" {
  description = "The name of workload"
  type        = string
  default     = "atlp"
}