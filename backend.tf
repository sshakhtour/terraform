# terraform {
#   backend "azurerm" {
#     resource_group_name  = "tf_state"
#     storage_account_name = "adportstfstatestorage"
#     container_name       = "tfstate"
#     key                  = "dev-terraform.tfstate"
#   }
# }

terraform {
  backend "azurerm" {
    resource_group_name  = "az-atlp-np-uaen-iac-rg"
    storage_account_name = "azatlpnpdevuaeniacsta"
    container_name       = "subs-atlp-nonprod-dev"
    key                  = "workloads_sub-atlp-nonprod-dev.tfstate"
  }
}