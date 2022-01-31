locals {
  aks_name = "az-${var.workload}-${var.environment}-%{ if var.region == "uaenorth" }uaen%{ else }uaec%{ endif }-aks"
} 
 
 module "rg" {
   source = "../../resources/base/resource_group"
   name = "az-${var.workload}-${var.environment}-%{ if var.region == "uaenorth" }uaen%{ else }uaec%{ endif }-rg"
   environment = var.environment
   region = var.region
   tags     = var.rg_tags
 }

module "role_acrpull" {
  source = "../../resources/authorization/role_assignment"
  scope  = var.create_registry == "true" ? module.container_registry[0].id : data.azurerm_container_registry.container_registry[0].id
  role_definition_name = "AcrPull"
  principal_id = module.aks.kubelet_identity.0.object_id
  depends_on = [module.aks]
}

data "azurerm_container_registry" "container_registry" {
  count               = var.create_registry == "true" ? 0 : 1
  name                = var.container_registry_name
  resource_group_name = var.container_registry_rg
}
module "container_registry" {
  count       = var.create_registry == "true" ? 1 : 0
  source      = "../../resources/container/acr"
  resource_group_name =  module.rg.name
  environment = var.environment
  region      = var.region
  sku         = var.acr_sku
  georeplication_locations = var.acr_sku == "Premium" ? var.georeplication_locations : null
  workload    = var.workload
  tags        = var.resource_tags
}

data "azuread_group" "aks_cluster_admins" {
  display_name = var.aks_admin_group #"aks-cluster-admins"
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

data "azurerm_subnet" "waf_subnet" {
  name                 = var.waf_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}



module "aks" {
  source      = "../../resources/container/aks"
  #version             = "4.8.0"
  resource_group_name = module.rg.name
  kubernetes_version               = var.kubernetes_version
  orchestrator_version             = var.kubernetes_version #"1.19.7"
  prefix                           = "az-${var.workload}-${var.environment}-%{ if var.region == "uaenorth" }uaen%{ else }uaec%{ endif }"
  network_plugin                   = "azure"
  vnet_subnet_id                   = data.azurerm_subnet.aks_subnet.id
  os_disk_size_gb                  = 50
  sku_tier                         = "Paid" # defaults to Free
  enable_role_based_access_control = true
  rbac_aad_admin_group_object_ids  = [data.azuread_group.aks_cluster_admins.id]
  rbac_aad_managed                 = true
  private_cluster_enabled          = false # default value
  enable_http_application_routing  = false
  enable_azure_policy              = true
  enable_auto_scaling              = false
  # agents_min_count                 = 1
  # agents_max_count                 = 2
  agents_size                      = var.system_agents_size
  agents_count                     = var.system_agents_count # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
  agents_max_pods                  = var.system_agents_max_pods
  agents_pool_name                 = "managedpool"
  #agents_availability_zones        = ["1", "2"]
  agents_type = "VirtualMachineScaleSets"
  agents_labels = {
    "nodepool" : "defaultnodepool"
  }

  agents_tags = {
    "Agent" : "defaultnodepoolagent"
  }

  network_policy                 = "azure"
  net_profile_dns_service_ip     = var.aks_dns_service_ip
  net_profile_docker_bridge_cidr = var.aks_docker_bridge_cidr
  net_profile_service_cidr       = var.aks_service_cidr
  
  tags                           = var.resource_tags
  depends_on = [module.rg]
}

module "node_pools" {
  source      = "../../resources/container/cluster_node_pool"
  aks_id =  module.aks.aks_id
  vm_size = var.user_agents_size
  kubernetes_version = var.kubernetes_version
  node_count = var.user_agents_count
  max_pods   = var.user_agents_max_pods
  tags        = var.resource_tags
  depends_on = [module.aks]
}

module "pip" {
  source      = "../../resources/network/public_ip"
  allocation_method =  "Static"
  name_prefix = "az-${var.workload}-${var.environment}"
  resource_group = module.rg.name
  environment = var.environment
  region      = var.region
  sku         = var.pip_sku
  tags        = var.resource_tags
}

module "appgw" {
  source      = "../../resources/network/application_gateway"
  resource_group_name =  module.rg.name
  region      = var.region
  environment = var.environment
  workload    = var.workload
  vnet_name      = var.vnet_name
  subnet_id = data.azurerm_subnet.waf_subnet.id
  public_ip_address_id = module.pip.id
  tags        = var.resource_tags
}

module "keyvault" {
  source      = "../../resources/secrets/keyvault"
  resource_group_name = module.rg.name
  workload    = var.workload    
  environment = var.environment
  region      = var.region
  tags        = var.resource_tags
}


provider "kubernetes" {
  host                   = module.aks.admin_host
  client_certificate     = base64decode(module.aks.admin_client_certificate)
  client_key             = base64decode(module.aks.admin_client_key)
  cluster_ca_certificate = base64decode(module.aks.admin_cluster_ca_certificate)
}

# enable identity in acr
resource "null_resource" "acr_managed_identity" {
  count      = var.create_registry == "true" ? 1 : 0
  depends_on = [module.container_registry]
  triggers = {
    timestamp = timestamp()
  }
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command = var.create_registry == "true" ? "az acr identity assign --identities [system] --name ${module.container_registry[0].name} --resource-group ${module.rg.name}":"echo blank step"
    # command     = <<-EOT
    #     az acr identity assign --identities [system] --name ${module.container_registry.name} --resource-group ${module.rg.name}
    #  EOT
  }
}

# enable agic addon
resource "null_resource" "aksagic_addon" {
  depends_on = [module.aks, module.appgw, module.node_pools]
  triggers = {
    timestamp = timestamp()
  }
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = <<-EOT
        appgwId=$(az network application-gateway show -n ${module.appgw.name} -g ${module.rg.name} -o tsv --query "id") 
        az aks enable-addons -n ${local.aks_name} -g ${module.rg.name}  -a ingress-appgw --appgw-id $appgwId
     EOT
  }
}

