variable "workload" {
  description = "The name of workload like ATLP"
  type        = string
}

variable "vnet_resource_group_name" {
  description = "the resource group name of vnet"
  type        = string
}


variable "vnet_name" {
  description = "the resource group name of vnet"
  type        = string
  default = ""
}

variable "aks_subnet_name" {
  description = "the subnet name that used by aks"
  type        = string
} 
variable "waf_subnet_name" {
  description = "the subnet name that used by waf"
  type        = string
} 
variable "aks_dns_service_ip" {
  description = "An IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range."
  type        = string
  default = "10.75.0.10"
} 

variable "aks_docker_bridge_cidr" {
  description = "An IP address and netmask assigned to Docker Bridge. It must not be in any Subnet IP ranges, or the Kubernetes service address range"
  type        = string
  default = "172.17.0.1/16"
} 

variable "aks_service_cidr" {
  description = "A CIDR notation IP range from which to assign service cluster IPs. It must not overlap with any Subnet IP ranges"
  type        = string
  default = "10.75.0.0/16"
} 
variable "kubernetes_version" {
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
  type        = string
  default     = null
}

variable "aks_admin_group" {
  description = "Azure Active Directory groups that will have admin access within the cluster."
  type        = string
  default = "az-aks-cluster-admins"
}

variable "system_agents_size" {
  default     = "Standard_D2s_v3"
  description = "The default virtual machine size for the Kubernetes system pool agents"
  type        = string
}

variable "user_agents_size" {
  default     = "Standard_D2s_v3"
  description = "The default virtual machine size for the Kubernetes user pool agents"
  type        = string
}
variable "system_agents_count" {
  description = "The number of Agents that should exist in the System Agent Pool."
  type        = number
  default     = 3
}

variable "user_agents_count" {
  description = "The number of Agents that should exist in the User Agent Pool."
  type        = number
  default     = 3
}

variable "system_agents_max_pods" {
  description = "The maximum number of pod which should exist within system Node Pool. Valid values are between 30 and 250."
  type        = number
  default     = 30
}

variable "user_agents_max_pods" {
  description = "The maximum number of pod which should exist within user Node Pool. Valid values are between 30 and 250."
  type        = number
  default     = 75
}
variable "rg_tags" {
  type        = map(string)
  description = "Any tags that should be present on the common with resource group resources"
  default     = {}
}

variable "resource_tags" {
  type        = map(string)
  description = "Any tags that should be present only in resources"
  default     = {}
}

###
# environment variables
###

#common
variable "environment" {
  description = "Development environment for resource; prod, non-prod, shared-services"
  type        = string
}

variable "region" {
  description = "Geographic region resource will be deployed into"
  type        = string
}

variable "acr_sku" {
  description = "The SKU name of the container registry. Possible values are Basic, Standard and Premium"
  type        = string
  default = "Standard"
}

variable "create_registry" {
  description = "flag to either create acr or not"
}

variable "container_registry_name" {
  description = "name of container registry that already exists"
  type = string
  default = ""
}

variable "container_registry_rg" {
  description = "resource group name of container registry that already exists"
  type = string
  default = ""
}
variable "georeplication_locations" {
  description = "Georeplication regions for Azure Container registry"
  default = ["uaecentral"]
}
variable "pip_sku" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
  type        = string
  default = "Standard"
}

#authentication

# variable "sp_client_id" {
#   description = "The Client ID (appId) for the Service Principal used for the AKS deployment"
# }

# variable "sp_client_secret" {
#   description = "The Client Secret (password) for the Service Principal used for the AKS deployment"
# }
# variable "sp_tenant_id" {
#   description = "The tenant id for the Service Principal used for the AKS deployment"
# }
# variable "subscription_id" {
#   description = "The subscription id that will be used to provision azure resources"
# }

variable "partner_id" {
  description = "the partner id to track ACR"
}




