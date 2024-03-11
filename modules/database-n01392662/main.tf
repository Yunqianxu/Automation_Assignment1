resource "azurerm_postgresql_server" "postgres_server" {
  name                = var.postgres_server_name
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.postgres_admin_username
  administrator_login_password = var.postgres_admin_password

  sku_name   = var.sku_name
  storage_mb = var.storage_mb
  version    = var.db_version

  backup_retention_days = var.backup_retention_days
  #   geo_redundant_backup  = var.geo_redundant_backup
  auto_grow_enabled = var.auto_grow_enabled

  public_network_access_enabled = true
  ssl_enforcement_enabled       = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  tags = var.tags
}
