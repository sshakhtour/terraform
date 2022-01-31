variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault"
}


variable "region" {
  description = "Geographisc Region resource will be deployed into"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map
  default     = {}
}