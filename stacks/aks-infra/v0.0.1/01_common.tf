## Exisiting RG
data "azurerm_resource_group" "rg-name" {
  name = var.resource_group_name
}

## Current User config
data "azurerm_client_config" "current" {}