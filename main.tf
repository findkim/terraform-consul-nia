# main.tf is downloaded from somewhere

terraform {
  required_version = "~> 0.12.21"

  required_providers {
    bigip = ">= 1.1.2"
    panos = ">= 1.6.2"
  }

  # backend "consul" {
  #   # Variables are not allowed for address and access_token
  #   # NMA will need to write these as ENV
  #   # address      = var.consul.address
  #   # access_token = var.consul.access_token
  #   scheme       = "https"
  #   path         = "nma/terraform"
  # }
}

locals {
  service_names = { for s in var.services : s.name => s }
}