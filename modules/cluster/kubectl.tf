locals {
  client_key_data                    = opentelekomcloud_cce_cluster_v3.cluster.certificate_users[0].client_key_data
  client_certificate_data            = opentelekomcloud_cce_cluster_v3.cluster.certificate_users[0].client_certificate_data
  kubectl_external_server            = try(opentelekomcloud_cce_cluster_v3.cluster.certificate_clusters[1].server, "")
  kubectl_internal_server            = opentelekomcloud_cce_cluster_v3.cluster.certificate_clusters[0].server
  cluster_certificate_authority_data = opentelekomcloud_cce_cluster_v3.cluster.certificate_clusters[0].certificate_authority_data
}

locals {
  kubectl_config = yamlencode({
    apiversion = "v1"
    clusters = [
      {
        cluster = {
          insecure-skip-tls-verify   = true
          server                     = local.kubectl_external_server
          #certificate-authority-data = local.cluster_certificate_authority_data
        }
        name = "${var.stage_name}-cluster"
      }
    ]
    contexts = [
      {
        context = {
          cluster = "${var.stage_name}-cluster"
          user    = "terraform"
        }
        name = "${var.stage_name}"
      }
    ]
    current-context = var.stage_name
    kind = "Config"
    preference = {}
    users = [
        {
        name = "terraform"
        user = {
          client-certificate-data = local.client_certificate_data
          client-key-data         = local.client_key_data
        }
      },
    ]

  })
}


resource "opentelekomcloud_s3_bucket" "kubeconfig" {
    bucket = "kubeconfig-${var.stage_name}"
    acl = "private"
    region = "eu-de"
    versioning {
      enabled = true
    }
}