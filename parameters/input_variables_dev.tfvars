region = "uaenorth"
environment = "dev"
workload = "atlp"
system_agents_size = "Standard_D2s_v3"
user_agents_size = "Standard_D2s_v3"
acr_sku = "Standard"
pip_sku = "Standard"
vnet_resource_group_name = "az-atlp-np-uaen-net-rg"
vnet_name = "az-atlp-np-dev-uaen-vnet"
aks_subnet_name = "atlp-np-dev-uaen-aks-snet"
waf_subnet_name = "atlp-np-dev-uaen-waf-snet"
aks_dns_service_ip = "192.168.0.10"
aks_docker_bridge_cidr = "172.27.0.1/16"
aks_service_cidr = "192.168.0.0/21"
kubernetes_version = "1.19.7"
aks_admin_group = "az-atlp-dev-aks-admins"
agents_count = "3"
rg_tags = {
                "ApplicationName" : "ATLP"
                "Owner" : "ATLP Team"
                "Environment" : "Dev"
                "Criticality" : "High"

              }
resource_tags = {
                "Owner" : "ATLP"
                "Criticality" : "High"
             }