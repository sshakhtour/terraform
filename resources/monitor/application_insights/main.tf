provider "azurerm" {
  features {}
  partner_id = var.partner_id
}

data "azurerm_resource_group" "this" {
  name  = var.resource_group_name
}

locals {
  tags                       = var.app_insights_additional_tags
}

# -
# - Application Insights
# -
resource "azurerm_application_insights" "this" {
  for_each            = var.application_insights
  name                = each.value["name"]
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  application_type                      = coalesce(lookup(each.value, "application_type"), "web")
  retention_in_days                     = lookup(each.value, "retention_in_days", null)
  daily_data_cap_in_gb                  = lookup(each.value, "daily_data_cap_in_gb", null)
  daily_data_cap_notifications_disabled = lookup(each.value, "daily_data_cap_notifications_disabled", null)
  sampling_percentage                   = lookup(each.value, "sampling_percentage", null)
  disable_ip_masking                    = lookup(each.value, "disable_ip_masking", null)

  tags = local.tags
}

