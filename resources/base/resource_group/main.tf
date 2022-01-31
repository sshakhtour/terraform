###
# resource composition
###

#resource group

resource "azurerm_resource_group" "base" {
  name     = var.name
  location = var.region
  tags     = var.tags
}