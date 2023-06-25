## Container Registry
resource "azurerm_container_registry" "container-registry" {
  location            = data.azurerm_resource_group.rg-name.location
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.rg-name.name
  sku                 = "Premium"

  retention_policy {
    days    = 30
    enabled = true
  }
}