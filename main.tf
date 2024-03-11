variable "location" {
  default = "Canada Central"
}

variable "common_tags" {
  default = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "firstname.lastname"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "resource_groups" {
  source   = "./modules/rgroup-n01392662"
  rg_name  = "n01392662-rg"
  location = var.location
  tags     = var.common_tags
}


module "network_module" {
  source              = "./modules/network-n01392662"
  vnet_name           = "n01392662_vnet"
  subnet_name         = "n01392662_subnet"
  location            = var.location
  resource_group_name = module.resource_groups.resource_group_name
  tags                = var.common_tags
}

module "common_n01392662_module" {
  source                       = "./modules/common-n01392662"
  resource_group_name          = module.resource_groups.resource_group_name
  location                     = var.location
  storage_account_name         = "n01392662sa"
  log_analytics_workspace_name = "n01392662-LAW"
  recovery_services_vault_name = "n01392662-RSV"
  tags                         = var.common_tags
}

module "linux_vm_module" {
  source               = "./modules/vmlinux-n01392662"
  resource_group_name  = module.resource_groups.resource_group_name
  location             = var.location
  linux_vm_names       = "n01392662-u-vm"
  vm_size              = "Standard_B1s"
  caching              = "ReadWrite"
  admin_username       = "Yunqi"
  public_key           = "~/.ssh/id_rsa.pub"
  private_key          = "~/.ssh/id_rsa"
  storage_account_uri  = module.common_n01392662_module.storage_account_primary_blob_endpoint
  storage_account_type = "Premium_LRS"
  disk_size            = 32
  os_publisher         = "OpenLogic"
  os_offer             = "CentOS"
  os_sku               = "8_2"
  os_version           = "latest"
  nb_count             = 3 # 3 required
  subnet_id            = module.network_module.subnet_id
  tags                 = var.common_tags
}

module "windows_vm_module" {
  source      = "./modules/vmwindows-n01392662"
  windows_avs = "windows_avs"
  windows_name = {
    "n01392662-w-vm1" = "Standard_B1s"
    # "n01392662-w-vm2" = "Standard_B1ms"
  }
  w_admin_username       = "Yunqi"
  w_admin_password       = "Xyq/1234567"
  w_storage_account_type = "StandardSSD_LRS"
  w_disk_size            = 128
  w_caching              = "ReadWrite"
  w_os_publisher         = "MicrosoftWindowsServer"
  w_os_offer             = "WindowsServer"
  w_os_sku               = "2016-Datacenter"
  w_os_version           = "latest"
  storage_account_uri    = module.common_n01392662_module.storage_account_primary_blob_endpoint
  resource_group_name    = module.resource_groups.resource_group_name
  location               = var.location
  subnet_id              = module.network_module.subnet_id
  tags                   = var.common_tags
}

module "datadisk_n01392662" {
  source              = "./modules/datadisk-n01392662"
  resource_group_name = module.resource_groups.resource_group_name
  location            = var.location
  vm_ids              = concat(module.windows_vm_module.windows_vm_id, module.linux_vm_module.linux_vm_id)
  vm_names            = concat(module.windows_vm_module.windows_vm_hostname, module.linux_vm_module.linux_vm_hostname)
  tags                = var.common_tags
}

module "loadbalancer-n01392662" {
  source              = "./modules/loadbalancer-n01392662"
  resource_group_name = module.resource_groups.resource_group_name
  location            = var.location
  tags                = var.common_tags
}

module "database-n01392662" {
  source                  = "./modules/database-n01392662"
  resource_group_name     = module.resource_groups.resource_group_name
  location                = var.location
  postgres_admin_username = "postgresadmin"
  postgres_admin_password = "n01392662!"
  sku_name                = "B_Gen5_2" # Example SKU
  storage_mb              = 5120       # 5GB
  db_version              = "11"
  backup_retention_days   = 7
  geo_redundant_backup    = "Disabled"
  auto_grow_enabled       = true
  tags                    = var.common_tags
}
