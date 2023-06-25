module "azure-infra" {
  source = "../../stacks/azure-infra/v0.0.1/"

  key_vault_name           = var.key_vault_name
  resource_group_name      = var.resource_group_name
  hub_vnet_name            = var.hub_vnet_name
  hub_vnet_address_space   = var.hub_vnet_address_space
  hub_subnet_name          = var.hub_subnet_name
  hub_subnet_address_space = var.hub_subnet_address_space
  acr_name                 = var.acr_name
  cluster_name             = var.cluster_name
  app_gateway_name         = var.app_gateway_name
  app_gateway_subnet_cidr  = var.app_gateway_subnet_cidr
  log_analytics_name       = var.log_analytics_name
  dns_service_ip           = var.dns_service_ip
  dns_service_cidr         = var.dns_service_cidr
  firewall_name            = var.firewall_name
}
