## Common
resource_group_name      = "rgazwuopsnp001"
key_vault_name           = "kv-np-des-001"
hub_vnet_name            = "vnet-np-westus-hub"
hub_vnet_address_space   = ["10.222.0.0/16"]
hub_subnet_name          = "AzureFirewallSubnet"
hub_subnet_address_space = ["10.222.0.0/22"]
acr_name                 = "crazureaks"
cluster_name             = "azure-np-westus"
app_gateway_name         = "agw-np-westus-1"
app_gateway_subnet_cidr  = "10.225.0.0/16"
log_analytics_name       = "log-np-westus-1"
dns_service_ip           = "10.0.0.10"
dns_service_cidr         = "10.0.0.0/16"
firewall_name            = "fw-np-westus-1"
