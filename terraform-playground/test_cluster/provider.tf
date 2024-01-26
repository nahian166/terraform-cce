/* provider "opentelekomcloud" {
  #user_name = "username"
  #password = "password"
  tenant_name = local.otc_tenant_name
  domain_name = local.otc_domain_name
  #region = "region name"
  access_key = module.environment.variable["ACCESS_KEY"]
  secret_key = module.environment.variable["SECRET_KEY"]
  auth_url = "https://iam.eu-de.otc.t-systems.com/v3"
} */

provider "opentelekomcloud" {
  cloud = "otc2"
  access_key = module.environment.variable["ACCESS_KEY"]
  secret_key = module.environment.variable["SECRET_KEY"]
  #auth_url = "https://iam.eu-de.otc.t-systems.com/v3"
  #tenant_name = local.otc_tenant_name
  #domain_name = local.otc_domain_name
  #token = var.token
  #user_name = "nahian"
}

provider "helm" {
    kubernetes {
        host = "${yamldecode(module.cluster.kubeconfig).clusters.1.cluster.server}"
        client_certificate = "${base64decode(yamldecode(module.cluster.kubeconfig).users.0.user.client-certificate-data)}"
        client_key = "${base64decode(yamldecode(module.cluster.kubeconfig).users.0.user.client-key-data)}"
        cluster_ca_certificate ="${base64decode(yamldecode(module.cluster.kubeconfig).clusters.0.cluster.certificate-authority-data)}"
    }
}

provider "kubernetes" {
        host = "${yamldecode(module.cluster.kubeconfig).clusters.1.cluster.server}"
        client_certificate = "${base64decode(yamldecode(module.cluster.kubeconfig).users.0.user.client-certificate-data)}"
        client_key = "${base64decode(yamldecode(module.cluster.kubeconfig).users.0.user.client-key-data)}"
        cluster_ca_certificate ="${base64decode(yamldecode(module.cluster.kubeconfig).clusters.0.cluster.certificate-authority-data)}"
}

#opentelekomcloud_cce_cluster_v3.cluster.certificate_clusters[0].certificate_authority_data

