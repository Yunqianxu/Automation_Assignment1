# Define output blocks for Windows virtual machines
#  (availability set, virtual machines, private IP addresses, and public IP addresses)
#   in modules/windows/outputs.tf file.

output "windows_vm_hostname" {
  value = values(azurerm_windows_virtual_machine.windows_vm)[*].name
}

output "windows_vm_id" {
  value = values(azurerm_windows_virtual_machine.windows_vm)[*].id
}

output "windows_private_ip" {
  value = values(azurerm_windows_virtual_machine.windows_vm)[*].private_ip_address
}

output "windows_public_ip" {
  value = values(azurerm_windows_virtual_machine.windows_vm)[*].public_ip_address
}

output "windoes_availability_set_name" {
  value = azurerm_availability_set.windows_avset.name
}
