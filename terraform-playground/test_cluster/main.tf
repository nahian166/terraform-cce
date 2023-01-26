/* module "cloud_tracing_service" {
    source = "../../modules/cloud_tracing_service"
} */

module "keypair" {
    source = "../../modules/keypair"
}

module "vpc" {
    source = "../../modules/vpc"
    vpc_cidr = local.vpc_cidr
    vpc_name = local.vpc_name
    subnet_cidr = local.subnet_cidr
    subnet_gateway_ip = local.vpc_subnet_gateway_ip
    subnet_name = local.subnet_name

}

module "cluster" {
    source = "../../modules/cluster"
    key_pair_id = module.keypair.keypair_name
    stage_name =local.stage_name
    vpc_id = module.vpc.vpc_id
    vpc_cidr = local.vpc_cidr
    subnet_id = module.vpc.subnet_id
    cluster_flavor_id = local.cluster_flavor_id
    cluster_node_flavor_id = local.node_spec_default
    availability_zone = local.availability_zone
    cluster_node_count = local.cluster_node_count
}

/* module "loadbalancer_v2" {
    source = "../../modules/loadbalancer_v2"
    stage_name = local.stage_name
    subnet_id = module.vpc.neutron_subnet_id
} */

/* output "loadbalancerv2_eip" {
    value = module.loadbalancer_v2.elb_public_ip
} */

module "loadbalancer_v3" {
    source = "../../modules/loadbalancer_v3"
    stage_name = local.stage_name
    router_id = module.vpc.vpc_id
    #subnet_id = module.vpc.neutron_subnet_id
    network_ids = module.vpc.network_id
    availability_zones = local.availability_zone
}

output "loadbalancerv3_eip" {
    value = module.loadbalancer_v3.elb_public_ip
}


# Get kubectl_config from a Vault
/* module "vault_terraform_secrets" {
  source = ""
  stage_name = local.stage_name
  kubectl_config = base64encode(module.cluster.kubectl_config) #kubectl_config stored in a vault system, here it fetches the kube config
  elb_id = module.loadbalancer.elb_id  #Traffic/Ingress needs this loadbalancer id
} */


