provider "azurerm" {
  features {}
  partner_id = var.partner_id
}

module "aks_agic" {
  source                   = "./modules/aks_agic"
  vnet_resource_group_name = var.vnet_resource_group_name
  region                   = var.region
  environment              = var.environment
  workload                 = var.workload
  system_agents_count      = var.system_agents_count
  user_agents_count        = var.user_agents_count
  system_agents_max_pods   = var.system_agents_max_pods
  user_agents_max_pods     = var.user_agents_max_pods
  vnet_name                = var.vnet_name
  aks_subnet_name          = var.aks_subnet_name
  waf_subnet_name          = var.waf_subnet_name
  kubernetes_version       = var.kubernetes_version
  aks_dns_service_ip       = var.aks_dns_service_ip
  aks_docker_bridge_cidr   = var.aks_docker_bridge_cidr
  aks_service_cidr         = var.aks_service_cidr
  system_agents_size       = var.system_agents_size
  user_agents_size         = var.user_agents_size
  acr_sku                  = var.acr_sku
  pip_sku                  = var.pip_sku
  aks_admin_group          = var.aks_admin_group
  partner_id               = var.partner_id
  rg_tags                  = var.rg_tags
  resource_tags            = var.resource_tags
  create_registry          = var.create_registry
  container_registry_name  = var.container_registry_name
  container_registry_rg    = var.container_registry_rg
  georeplication_locations = var.georeplication_locations
}



