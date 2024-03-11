output "datadisk_ids" {
  value = { for k, v in azurerm_managed_disk.datadisk : k => v.id }
}
