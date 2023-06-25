resource "azurerm_route_table" "aks-route-table" {
  depends_on                    = [azurerm_subnet.firewall-subnet]
  name                          = "aks-route-table"
  location                      = data.azurerm_resource_group.rg-name.location
  resource_group_name           = data.azurerm_resource_group.rg-name.name
  disable_bgp_route_propagation = false

  route {
    name                   = "aks-route"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }

  route {
    name                   = "aks-route-internet"
    address_prefix         = "${azurerm_public_ip.firewall-ip.ip_address}/32"
    next_hop_type          = "Internet"
  }
}
