## KeyVault
resource "azurerm_key_vault" "keyvault" {
  location                    = data.azurerm_resource_group.rg-name.location
  name                        = var.key_vault_name
  resource_group_name         = data.azurerm_resource_group.rg-name.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "premium"
  enabled_for_disk_encryption = true
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7
}

## Access Policies
resource "azurerm_key_vault_access_policy" "current_user" {
  key_vault_id = azurerm_key_vault.keyvault.id
  object_id    = data.azurerm_client_config.current.object_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  key_permissions = [
    "Get",
    "Create",
    "Delete",
    "GetRotationPolicy",
    "Recover",
  ]
}

resource "azurerm_key_vault_access_policy" "des" {
  key_vault_id = azurerm_key_vault.keyvault.id
  object_id    = azurerm_disk_encryption_set.des.identity[0].principal_id
  tenant_id    = azurerm_disk_encryption_set.des.identity[0].tenant_id
  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey"
  ]
}

## Des Key
resource "azurerm_key_vault_key" "des_key" {
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
  key_type        = "RSA-HSM"
  key_vault_id    = azurerm_key_vault.keyvault.id
  name            = "azure-des-kv-key"
  key_size        = 2048

  depends_on = [
    azurerm_key_vault_access_policy.current_user
  ]
}

## Des Key with OS
resource "azurerm_disk_encryption_set" "des" {
  key_vault_key_id    = azurerm_key_vault_key.des_key.id
  location            = data.azurerm_resource_group.rg-name.location
  name                = "des"
  resource_group_name = data.azurerm_resource_group.rg-name.name

  identity {
    type = "SystemAssigned"
  }
}


