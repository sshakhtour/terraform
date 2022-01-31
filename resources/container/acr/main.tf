locals {
  tags = {
    Role  = "Container Registry"
  }
}

#container registry
resource "azurerm_container_registry" "base" {
  name                     = "${var.workload}${var.environment}%{ if var.region == "uaenorth" }uaen%{ else }uaec%{ endif }cr"
  resource_group_name      = var.resource_group_name
  location                 = var.region
  sku                      = var.sku
  admin_enabled            = var.admin_enabled
  georeplication_locations = var.georeplication_locations
  tags                     = merge(var.tags, local.tags)
  dynamic "network_rule_set" {
    for_each = var.network_rule_set
    content {
      default_action = network_rule_set.value.default_action
      ip_rule {
        action   = network_rule_set.value.ip_rule_action
        ip_range = network_rule_set.value.ip_rule_ip_range
      }
      virtual_network {
        action    = network_rule_set.value.virtual_network_action
        subnet_id = network_rule_set.value.subnet_id
      }
    }
  }
}