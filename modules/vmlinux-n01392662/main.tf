# Availability Set
#Define a new resource block for availability set with 2 fault domains and 5 update domains.
#deploy more instances to fail safe
resource "azurerm_availability_set" "n01392662_avs" {
  name                         = "linux-avset"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  tags                         = var.tags
}

# Network Watcher Extension
resource "azurerm_virtual_machine_extension" "network_watcher" {
  count                      = var.nb_count
  name                       = "NetworkWatcherAgent${count.index}"
  virtual_machine_id         = element(azurerm_linux_virtual_machine.n01392662_vm.*.id, count.index)
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true
  tags                       = var.tags
}


# Azure Monitor Extension
resource "azurerm_virtual_machine_extension" "azure_monitor" {
  count                      = var.nb_count
  name                       = "AzureMonitorLinuxAgent${count.index}"
  virtual_machine_id         = element(azurerm_linux_virtual_machine.n01392662_vm.*.id, count.index)
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags                       = var.tags
}

resource "azurerm_network_interface" "linux_nic" {
  count               = var.nb_count
  name                = "${var.linux_vm_names}${format("%1d", count.index + 1)}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location
  #   depends_on          = [azurerm_subnet_network_security_group_association.subnet_nsg_association] #???

  ip_configuration {
    name                          = "${var.linux_vm_names}${format("%1d", count.index)}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.n01392662_vm_pip.*.id, count.index)
  }
  tags = var.tags
}

resource "azurerm_public_ip" "n01392662_vm_pip" {
  name                = "${var.linux_vm_names}${format("%1d", count.index)}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.linux_vm_names}${format("%1d", count.index)}"
  count               = var.nb_count
  # sku                 = "Standard"
  # zones               = [var.zone]
  tags = var.tags
}

# Virtual Machines
resource "azurerm_linux_virtual_machine" "n01392662_vm" {
  count                           = var.nb_count
  name                            = "${var.linux_vm_names}${format("%1d", count.index)}"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  computer_name                   = "${var.linux_vm_names}${format("%1d", count.index)}"
  admin_username                  = var.admin_username
  disable_password_authentication = true
  network_interface_ids           = [element(azurerm_network_interface.linux_nic[*].id, count.index)]
  depends_on                      = [azurerm_availability_set.n01392662_avs]
  availability_set_id             = azurerm_availability_set.n01392662_avs.id
  #either availability set and zone can be choosed
  # zone = var.zone
  os_disk {
    name                 = "${var.linux_vm_names}${format("%1d", count.index)}-os-disk"
    caching              = var.caching
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size
  }
  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }
  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key)
  }



  provisioner "remote-exec" {
    inline = [
      "echo VM hostname: $(hostname)"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip_address
      user        = var.admin_username
      private_key = file(var.private_key)
      agent       = false
    }
  }

  tags = var.tags
}
