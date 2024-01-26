terraform {
  required_providers {
    opentelekomcloud = {
        source = "opentelekomcloud/opentelekomcloud"
        version = "1.32.0"
    }
  }
}


resource "opentelekomcloud_vpc_eip_v1" "kubectl_eip" {
  bandwidth {
    charge_mode = "traffic"
    name        = "${var.stage_name}-kubectl-bw"
    share_type  = "PER"
    size        = 10
  }
  publicip {
    type    = "5_bgp"
  
  }

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

resource "time_sleep" "wait_for_kubernetes" {

    depends_on = [
        opentelekomcloud_cce_cluster_v3.cluster
    ]

    create_duration = "30s"
}

# data "opentelekomcloud_cce_cluster_kubeconfig_v3" "this" {
#   cluster_id = opentelekomcloud_cce_cluster_v3.cluster.id
# }

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



output "id" {
  value = opentelekomcloud_cce_cluster_v3.cluster.id 
}


data "opentelekomcloud_cce_cluster_kubeconfig_v3" "this" {
  depends_on = [ opentelekomcloud_cce_cluster_v3.cluster ]
  cluster_id = opentelekomcloud_cce_cluster_v3.cluster.id
}

 output kubeconfig {
   value = data.opentelekomcloud_cce_cluster_kubeconfig_v3.this.kubeconfig
 }

# resouce "kubectl_manifest" "cert-manager" { depends_on = [] yaml_body = <<YAML apiVersion:.... YAML}