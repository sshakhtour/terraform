locals {
  tags = {
    Role  = "Key Vault"
  }
}

data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "keyvault" {
  name                        = "az-${var.workload}-${var.environment}-%{ if var.region == "uaenorth" }uaen%{ else }uaec%{ endif }-kv"
  location                    = var.region
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
  tags =  merge(var.tags, local.tags)
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]

    certificate_permissions  = [
      "Get",
    ]
  }
}