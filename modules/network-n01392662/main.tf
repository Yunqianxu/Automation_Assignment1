resource "azurerm_virtual_network" "n01392662_vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "n01392662_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.n01392662_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# resource "azurerm_network_security_group" "n01392662_nsg" {
#   name                = "${var.vnet_name}-NSG"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   tags                = var.tags
# }

resource "azurerm_network_security_group" "n01392662_nsg" {
  name                = "n01392662-sg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "rule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule2"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "rule3"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.n01392662_subnet.id
  network_security_group_id = azurerm_network_security_group.n01392662_nsg.id
}
