locals {
  tags = {
    Role  = "Traffic Manager"
  }
}

resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}

resource "azurerm_traffic_manager_profile" "tfm" {
  name                   = random_id.server.hex
  resource_group_name    = var.resource_group_name
  traffic_routing_method = "Geographic"

  dns_config {
    relative_name = random_id.server.hex
    ttl           = 100
  }

  monitor_config {
    protocol                     = "http"
    port                         = 80
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
  }

  tags = merge(var.tags, local.tags)
}