# panos.tf manages PANOS firewall security policy rules for Consul services
#
# This file is autogenerated by Consul NMA. Any manul updates to this
# file will be clobbered. Once module count is supported by Terraform,
# this templated file will be merged with main.tf.

provider "panos" {
  hostname = var.panos.hostname
  username = var.panos.username
  password = var.panos.password
  api_key  = var.panos.api_key
  protocol = var.panos.protocol != null ? var.panos.protocol : "https"
  port     = var.panos.port != null ? var.panos.port : 0
  timeout  = var.panos.timeout != null ? var.panos.timeout : 10
}

module "panos" {
  source = "./modules/panos"

  services = { for name in var.service_mapping["panos"] : name => var.services[name] if length(var.services[name].addresses) > 0 }
}
