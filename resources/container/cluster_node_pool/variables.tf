variable "aks_id" {
  type        = string
  description = "The ID of the Kubernetes Cluster where this Node Pool should exist. Changing this forces a new resource to be created."
}

variable "vm_size" {
  description = "The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created."
  type        = string
}

variable "node_count" {
  description = "The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count"
  type        = string
}

variable "max_pods" {
  description = "The maximum number of pod which should exist within this Node Pool. Valid values are between 30 and 250"
  type        = string
}

variable "kubernetes_version" {
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
  type        = string
  default     = null
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map
  default     = {}
}