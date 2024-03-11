output "linux_vm_hostname" {
  value = azurerm_linux_virtual_machine.n01392662_vm[*].name
}

output "linux_vm_id" {
  value = azurerm_linux_virtual_machine.n01392662_vm[*].id
}

output "vm_fqdn" {
  value = azurerm_public_ip.n01392662_vm_pip[*].fqdn
}

output "private_ip_address" {
  value = azurerm_network_interface.linux_nic[*].private_ip_address
}

output "public_ip_address" {
  value = azurerm_public_ip.n01392662_vm_pip[*].ip_address
}

output "linux_availability_set_name" {
  value = azurerm_availability_set.n01392662_avs.name
}
