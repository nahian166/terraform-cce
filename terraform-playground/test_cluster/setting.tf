terraform {
  required_providers {
    opentelekomcloud = {
        source = "opentelekomcloud/opentelekomcloud"
        version = "1.32.0"
    }
    kubernetes = {
        source = "hashicorp/kubernetes"
        version = "2.8.0"     
    }
    helm = {
        source = "hashicorp/helm"
        version = "2.4.1"
    }
  }
}

