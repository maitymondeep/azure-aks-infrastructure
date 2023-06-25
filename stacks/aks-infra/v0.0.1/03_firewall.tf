## Firewall VNet Name
resource "azurerm_virtual_network" "hub-vnet" {
  address_space       = var.hub_vnet_address_space
  location            = data.azurerm_resource_group.rg-name.location
  name                = var.hub_vnet_name
  resource_group_name = data.azurerm_resource_group.rg-name.name
}

## Firewall Subnet Namme
resource "azurerm_subnet" "firewall-subnet" {
  address_prefixes     = var.hub_subnet_address_space
  name                 = var.hub_subnet_name
  resource_group_name  = data.azurerm_resource_group.rg-name.name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
}

## Firewall Public IP
resource "azurerm_public_ip" "firewall-ip" {
  name                = "${var.firewall_name}-pip"
  location            = data.azurerm_resource_group.rg-name.location
  resource_group_name = data.azurerm_resource_group.rg-name.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

## Azure Firewall
resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  location            = data.azurerm_resource_group.rg-name.location
  resource_group_name = data.azurerm_resource_group.rg-name.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall-subnet.id
    public_ip_address_id = azurerm_public_ip.firewall-ip.id
  }
}
