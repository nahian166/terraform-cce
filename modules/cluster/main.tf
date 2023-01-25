terraform {
  required_providers {
    opentelekomcloud = {
        source = "opentelekomcloud/opentelekomcloud"
        version = "1.32.0"
    }
  }
}

variable "stage_name" {}

resource "opentelekomcloud_vpc_eip_v1" "kubectl_eip" {
  bandwidth {
    charge_mode = "traffic"
    name        = "${var.stage_name}-kubectl-bandwidth"
    share_type  = "PER"
    size        = 100
  }
  publicip {
    type    = "5_bgp"
    #port_id = opentelekomcloud_lb_loadbalancer_v2.elb.vip_port_id
  }
  #region = var.region
}
resource "opentelekomcloud_cce_cluster_v3" "cluster" {
  name                   = "${var.stage_name}-cluster"
  cluster_type           = "VirtualMachine"
  container_network_type = "overlay_l2"
  authentication_mode    = "rbac"
  flavor_id              = var.cluster_flavor_id
  vpc_id                 = var.vpc_id
  subnet_id              = var.subnet_id
  eip = opentelekomcloud_vpc_eip_v1.kubectl_eip.publicip[0].ip_address
  #kube_proxy_mode        = "ipvs"
  #cluster_version        = var.cluster_version
  #eip                    = opentelekomcloud_networking_floatingip_v2.cluster.address
  #annotations = { 
  #"cluster.install.addons.external/install" = "[{\"addonTemplateName\":\"icagent\"}]"  }
  #container_network_type = var.container_network_type
  
}

resource "opentelekomcloud_cce_node_v3" "nodes" {
    #for_each = var.nodes
    count             = var.cluster_node_count
    name              = "${var.stage_name}-node-${count.index}"
    cluster_id        = opentelekomcloud_cce_cluster_v3.cluster.id
    availability_zone = var.availability_zone
    eip_count         = 0
    flavor_id         = var.cluster_node_flavor_id
    key_pair          = var.key_pair_id

    root_volume {
        size       = 100
        volumetype = "SSD"
    }

    data_volumes {
        size       = 100
        volumetype = "SSD"
    }
}

output "endpoint" {
  value = local.kubectl_external_server
}

output "client-certificate" {
  value = local.client_certificate_data  
}