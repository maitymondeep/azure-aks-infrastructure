## Network Rules for Firewall
resource "azurerm_firewall_network_rule_collection" "aksfwnr" {
  name                = "aksfwnr"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = data.azurerm_resource_group.rg-name.name
  priority            = 101
  action              = "Allow"

  rule {
    name              = "time"
    source_addresses  = ["*"]
    destination_ports = ["123"]
    destination_addresses = ["*"]
    protocols = [
      "UDP"
    ]
  }
  rule {
    name                  = "apiudp"
    source_addresses      = ["*"]
    destination_ports     = ["9000"]
    destination_addresses = ["AzureCloud.${data.azurerm_resource_group.rg-name.location}"]
    protocols = [
      "TCP"
    ]
  }
  rule {
    name                  = "apitcp"
    source_addresses      = ["*"]
    destination_ports     = ["1194"]
    destination_addresses = ["AzureCloud.${data.azurerm_resource_group.rg-name.location}"]
    protocols = [
      "UDP"
    ]
  }
  rule {
    name                  = "dns"
    source_addresses      = ["*"]
    destination_ports     = ["53"]
    destination_addresses = ["*"]
    protocols = [
      "Any"
    ]
  }
}

resource "azurerm_firewall_network_rule_collection" "servicetags" {
  name                = "servicetags"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = data.azurerm_resource_group.rg-name.name
  priority            = 200
  action              = "Allow"

  rule {
    name              = "allow service tags"
    source_addresses  = ["*"]
    destination_ports = ["*"]
    destination_addresses = [
      "AzureContainerRegistry.${data.azurerm_resource_group.rg-name.location}",
      "MicrosoftContainerRegistry.${data.azurerm_resource_group.rg-name.location}",
      "AzureActiveDirectory",
      "AzureMonitor",
      "AzureWebPubSub",
      "Storage",
      "StorageSyncService"
    ]
    protocols = [
      "Any"
    ]
  }
}

## Application Rules for Firewall
resource "azurerm_firewall_application_rule_collection" "aksfwar" {
  name                = "aksfwar"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = data.azurerm_resource_group.rg-name.name
  priority            = 101
  action              = "Allow"

  rule {
    name             = "fqdn"
    source_addresses = ["*"]
    fqdn_tags        = ["AzureKubernetesService"]
  }
}

resource "azurerm_firewall_application_rule_collection" "osupdates" {
  name                = "osupdates"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = data.azurerm_resource_group.rg-name.name
  priority            = 102
  action              = "Allow"

  rule {
    name             = "allow network"
    source_addresses = ["*"]
    target_fqdns = [
      "download.opensuse.org",
      "security.ubuntu.com",
      "packages.microsoft.com",
      "azure.archive.ubuntu.com",
      "changelogs.ubuntu.com",
      "snapcraft.io",
      "api.snapcraft.io",
      "motd.ubuntu.com"
    ]
    protocol {
      port = "443"
      type = "Https"
    }
    protocol {
      port = "80"
      type = "Http"
    }
  }
}

resource "azurerm_firewall_application_rule_collection" "dockerhub" {
  name                = "dockerhub"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = data.azurerm_resource_group.rg-name.name
  priority            = 200
  action              = "Allow"

  rule {
    name             = "allow network"
    source_addresses = ["*"]
    target_fqdns = [
      "*auth.docker.io",
      "*cloudflare.docker.io",
      "*cloudflare.docker.com",
      "*registry-1.docker.io",
      "*registry.k8s.io",
      "*us-west2-docker.pkg.dev"
    ]
    protocol {
      port = "443"
      type = "Https"
    }
    protocol {
      port = "80"
      type = "Http"
    }
  }
}