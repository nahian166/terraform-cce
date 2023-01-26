terraform {
  required_providers {
    opentelekomcloud = {
        source = "opentelekomcloud/opentelekomcloud"
        version = "1.32.0"
    }
  }
}

resource "opentelekomcloud_lb_loadbalancer_v3" "elb" {
  name          = "elb-${var.stage_name}_ded"
  #subnet_id = var.subnet_id
  router_id = var.router_id
  network_ids = [var.network_ids]
  availability_zones = [var.availability_zones]
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
    value =  opentelekomcloud_lb_loadbalancer_v3.elb.id  
}

output "elb_public_ip" {
    value = opentelekomcloud_vpc_eip_v1.ingress_eip.publicip[0].ip_address
}
