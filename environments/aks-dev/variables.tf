variable "resource_group_name" {
  type    = string
  description = "Name of the RG"
}
variable "key_vault_name" {
  type        = string
  description = "Name of the Key Vault"
}
variable "hub_vnet_name" {
  type        = string
  description = "Name of the VNet"
}
variable "hub_vnet_address_space" {
  type        = list(any)
  description = "Vnet Address Spcace"
}
variable "hub_subnet_name" {
  type        = string
  description = "Name of the Hub Subnet"
}
variable "hub_subnet_address_space" {
  type        = list(any)
  description = "Subnet Address Spcace"
}
variable "acr_name" {
  type        = string
  default     = null
  description = "Name of the ACR"
}
variable "cluster_name" {
  type        = string
  default     = null
  description = "Name of the Cluster"
}
variable "app_gateway_name" {
  type        = string
  default     = null
  description = "Name of the app Gateway"
}
variable "app_gateway_subnet_cidr" {
  type        = string
  default     = null
  description = "Name of the app Gateway Subnet CIDR"
}
variable "log_analytics_name" {
  type        = string
  default     = null
  description = "Name of the Log Analytics"
}
variable "dns_service_ip" {
  type    = string
  default = null
}
variable "dns_service_cidr" {
  type    = string
  default = null
}
variable "firewall_name" {
  type        = string
  description = "Name of the app Gateway Subnet CIDR"
}
