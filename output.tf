output "linux_vm_hostname" {
  value = module.linux_vm_module.linux_vm_hostname
}

output "windows_vm_hostname" {
  value = module.windows_vm_module.windows_vm_hostname
}

output "datebase_name" {
  value = module.database-n01392662.postgresql_server_name
}

output "loadbalancer_name" {
  value = module.loadbalancer-n01392662.load_balancer_name
}

output "datadisk_id" {
  value = module.datadisk_n01392662.datadisk_ids
}
