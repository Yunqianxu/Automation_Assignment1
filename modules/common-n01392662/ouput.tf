output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.n01392662_law.name
}

output "recovery_services_vault_name" {
  value = azurerm_recovery_services_vault.n01392662_rsv.name
}

output "storage_account_id" {
  value = azurerm_storage_account.n01392662_sa.id
}

output "storage_account_primary_blob_endpoint" {
  value = azurerm_storage_account.n01392662_sa.primary_blob_endpoint
}
