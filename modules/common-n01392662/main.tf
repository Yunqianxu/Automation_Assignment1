# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "n01392662_law" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
   tags = var.tags
}

# Recovery Services Vault
resource "azurerm_recovery_services_vault" "n01392662_rsv" {
  name                = var.recovery_services_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
   tags = var.tags
}

# Storage Account
resource "azurerm_storage_account" "n01392662_sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
   tags = var.tags
}