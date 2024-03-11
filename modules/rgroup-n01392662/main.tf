resource "azurerm_resource_group" "humber_rg" {
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}
