resource "azurerm_managed_disk" "datadisk" {
  for_each             = { for i, val in var.vm_ids : i => val }
  name                 = "${each.key}-data-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "datadisk_attachment" {
  for_each           = { for i, val in var.vm_ids : i => val }
  managed_disk_id    = azurerm_managed_disk.datadisk[each.key].id
  virtual_machine_id = var.vm_ids[each.key]
  lun                = 0
  caching            = "ReadWrite"
}

