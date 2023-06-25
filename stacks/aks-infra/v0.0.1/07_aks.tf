resource "random_id" "prefix" {
  byte_length = 6
}

## Config for Windows Nodepool
locals {
  nodes = {
    for i in range(1) : "worker${i}" => {
      name                = substr("win${i}${random_id.prefix.hex}", 0, 6)
      vm_size             = "Standard_D2s_v3"
      os_type             = "Windows"
      os_sku              = "Windows2019"
      enable_auto_scaling = true
      max_pods            = 50
      min_count           = 1
      max_count           = 3
      windows_profile      = {
        outbound_nat_enabled = true
      }
    }
  }
}

module "aks" {
  source  = "Azure/aks/azurerm"
  version = "6.8.0"

  prefix                       = var.cluster_name
  resource_group_name          = data.azurerm_resource_group.rg-name.name
  kubernetes_version           = "1.25" # don't specify the patch version!
  orchestrator_version         = "1.25" # don't specify the patch version!
  automatic_channel_upgrade    = "patch"
  agents_count                 = 3
  agents_max_pods              = 30
  agents_size                  = "Standard_D2s_v3"
  agents_pool_name             = "nodepool"
  only_critical_addons_enabled = false
  agents_pool_linux_os_configs = [
    {
      transparent_huge_page_enabled = "always"
      sysctl_configs = [{
        fs_aio_max_nr               = 65536
        fs_file_max                 = 100000
        fs_inotify_max_user_watches = 1000000
      }]
    }
  ]
  agents_type = "VirtualMachineScaleSets"
  node_pools                   = local.nodes
  attached_acr_id_map = {
    example = azurerm_container_registry.container-registry.id
  }
  azure_policy_enabled                    = true
  disk_encryption_set_id                  = azurerm_disk_encryption_set.des.id
  enable_auto_scaling                     = false
  enable_host_encryption                  = true
  http_application_routing_enabled        = true
  ingress_application_gateway_enabled     = true
  ingress_application_gateway_name        = var.app_gateway_name
  ingress_application_gateway_subnet_cidr = var.app_gateway_subnet_cidr
  local_account_disabled                  = true
  log_analytics_workspace_enabled         = true
  cluster_log_analytics_workspace_name    = var.log_analytics_name
  net_profile_dns_service_ip              = var.dns_service_ip
  net_profile_service_cidr                = var.dns_service_cidr
  network_plugin                          = "azure"
  network_policy                          = "azure"
  os_disk_size_gb                         = 100
  private_cluster_enabled                 = false
  private_cluster_public_fqdn_enabled     = false
  public_network_access_enabled           = true
  rbac_aad                                = true
  rbac_aad_azure_rbac_enabled             = true
  rbac_aad_managed                        = true
  role_based_access_control_enabled       = true
  rbac_aad_admin_group_object_ids         = ["bdff56b0-973d-4978-b1ab-399536f48986"]
  sku_tier                                = "Standard"
}