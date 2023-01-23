module "cloud_tracing_service" {
    source = "../../modules/cloud_tracing_service"
}

module "keypair" {
    source = "../../modules/keypair"
    #stage_name = local.stage_name
}

module "vpc" {
    source = "../../modules/vpc"
    vpc_cidr = local.vpc_cidr
    vpc_name = local.vpc_name
    #stage_name = local.stage_name
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
    #subnet_id = opentelekomcloud_vpc_subnet_v1.subnet.subnet_id
    flavor_id = "cce.s1.small"
    nodes = local.node_spec
    availability_zone = "eu-de-03"
    cluster_node_count = local.cluster_node_count
}

module "loadbalancer" {
    source = "../../modules/loadbalancer"
    stage_name = local.stage_name
    subnet_id = module.vpc.neutron_subnet_id
    region = "eu-de"
    tenant_id = "42225bcefc3340c68262eed3a9534dc8"
    #network_id = module.vpc.network_id
}

output "loadbalanver_eip" {
    value = module.loadbalancer.elb_public_ip
}

# Get kubectl_config from a Vault
/* module "vault_terraform_secrets" {
  source = ""
  stage_name = local.stage_name
  kubectl_config = base64encode(module.cluster.kubectl_config) #kubectl_config stored in a vault system, here it fetches the kube config
  elb_id = module.loadbalancer.elb_id  #Traffic/Ingress needs this loadbalancer id
} */


