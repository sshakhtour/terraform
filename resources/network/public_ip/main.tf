locals {
  tags = {
    Role  = "Public IP address"
  }
}

#public ip
resource "azurerm_public_ip" "base" {
  name                    = "${var.name_prefix}-pip"
  resource_group_name     = var.resource_group
  location                = var.region
  allocation_method       = var.allocation_method
  sku                     = var.sku
  ip_version              = var.ip_version
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  domain_name_label       = var.domain_name_label
  reverse_fqdn            = var.reverse_fqdn
  public_ip_prefix_id     = var.public_ip_prefix_id
  zones                   = var.zones
  tags                    = merge(var.tags, local.tags)
}