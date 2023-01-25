terraform {
  required_providers {
    opentelekomcloud = {
        source = "opentelekomcloud/opentelekomcloud"
        version = "1.32.0"
    }
  }
}

resource "opentelekomcloud_vpc_v1" "vpc" {
  name   = var.vpc_name
  cidr   = var.vpc_cidr
  shared = true
}

resource "opentelekomcloud_vpc_subnet_v1" "subnet" {
  name       = var.subnet_name
  vpc_id     = opentelekomcloud_vpc_v1.vpc.id
  cidr       = var.subnet_cidr
  gateway_ip = var.subnet_gateway_ip
  #dns_list   = var.dns_config
}

output "subnet_id" {
    value = opentelekomcloud_vpc_subnet_v1.subnet.id
}

output "vpc_id" {
  value = opentelekomcloud_vpc_v1.vpc.id
}

output "network_id" {
    value = opentelekomcloud_vpc_subnet_v1.subnet.network_id
}

output "neutron_subnet_id" {
  value = opentelekomcloud_vpc_subnet_v1.subnet.subnet_id
}