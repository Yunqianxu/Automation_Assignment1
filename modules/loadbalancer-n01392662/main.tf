resource "azurerm_lb" "n01392662_lb" {
  name                = "n01392662_lb"
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "n01392662_lb_fronted_ip_config"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
  tags = var.tags
}

resource "azurerm_public_ip" "lb_pip" {
  name                = "lb_pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  tags                = var.tags
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.n01392662_lb.id
  name            = "n01392662_azurerm_lb_backend_address_pool"
}

# Assuming the association between VMs and the load balancer's backend pool
# is handled outside this module or dynamically linked via input variables.
