variable "resource_group_name" {
  description = "The name of the resource group where the PostgreSQL server will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where the PostgreSQL server will be created"
  type        = string
}

variable "postgres_server_name" {
  description = "The name of the PostgreSQL server instance"
  type        = string
  default     = "n01392662-psqlserver"
}

variable "postgres_admin_username" {
  description = "The administrator username for the PostgreSQL server"
  type        = string
}

variable "postgres_admin_password" {
  description = "The administrator password for the PostgreSQL server"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "The SKU name for the PostgreSQL server"
}

variable "storage_mb" {
  description = "Max storage allowed for the PostgreSQL server (in MB)"
}

variable "db_version" {
  description = "The version of PostgreSQL to use"
}

variable "backup_retention_days" {
  description = "The backup retention days for the PostgreSQL server"
}

variable "geo_redundant_backup" {
  description = "Enable or disable geo-redundant backup"
}

variable "auto_grow_enabled" {
  description = "Enable or disable auto grow of the storage"
}

variable "tags" {

}
