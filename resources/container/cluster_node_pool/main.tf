locals {
  tags = {
    Role  = "Node Pools"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "base" {
  name                  = "userpool1"
  kubernetes_cluster_id = var.aks_id
  vm_size               = var.vm_size
  node_count            = var.node_count
  orchestrator_version = var.kubernetes_version
  max_pods = var.max_pods
  tags = merge(var.tags, local.tags)
}