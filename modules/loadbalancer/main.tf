terraform {
  required_providers {
    opentelekomcloud = {
        source = "opentelekomcloud/opentelekomcloud"
        version = "1.32.0"
    }
  }
}

resource "opentelekomcloud_lb_loadbalancer_v2" "elb" {
  name          = "elb-${var.stage_name}"
  vip_subnet_id = var.subnet_id
  region = var.region
  #network_ids = [var.network_id]
  #availability_zones = [var.az]
  tenant_id = var.tenant_id
}

resource "opentelekomcloud_vpc_eip_v1" "ingress_eip" {
  publicip {
    type = "5_bgp"
  }
  bandwidth {
    name        = "${var.stage_name}-tf-ingress-nahian"
    size        = 50
    share_type  = "PER"
    charge_mode = "traffic"
  }
}

output "elb_id" {
    value =  opentelekomcloud_lb_loadbalancer_v2.elb.id  
}

output "elb_public_ip" {
    value = opentelekomcloud_vpc_eip_v1.ingress_eip.publicip[0].ip_address
}
