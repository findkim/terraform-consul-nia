resource "panos_application_object" "service" {
  for_each = var.services

  name        = each.value["name"]
  description = each.value["description"]
  category    = "consul-nma"
  subcategory = "terraform"
  technology  = "automated"
}

resource "panos_security_policy" "service" {
  # https://docs.paloaltonetworks.com/pan-os/9-0/pan-os-admin/policy/security-policy/components-of-a-security-policy-rule.html
  dynamic "rule" {
    for_each = var.services

    content {
      name        = each.name
      action      = "allow"
      description = "Security policy rule autogenerated by Consul NMA through Terraform"
      tags        = ["consul-nma"]

      applications          = [each.name]
      source_zones          = ["any"]
      source_addresses      = [for addr in each.sources : addr]
      source_users          = ["any"]
      hip_profiles          = ["any"]
      destination_zones     = ["any"]
      destination_addresses = [for addr in each.destinations : addr]
      services              = ["application-default"]
      categories            = []
    }
  }
}

variable "services" {
  description = "Consul services monitored by NMA"
  type = list(object({
    # Name of the service
    name = string
    # Description of the service
    description = string
    # List of addresses for instances of the service
    addresses = list(string)
    # List of source addresses that initiates network communcation with
    # the service
    sources = list(string)
    # List of destination addresses that the service initiates network
    # communication with
    destinations = list(string)
  }))
  default = []
}