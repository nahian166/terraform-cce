terraform {
  required_providers {
    opentelekomcloud = {
        source = "opentelekomcloud/opentelekomcloud"
        version = "1.32.0"
    }
/*     external = {
        source = "hashicorp/external"
        version = ">= 1.2"
    } */
  }
  backend "s3" {
    key = "tfstate"
    bucket = "nahian-tfstate-bucket"
    region = "eu-de"
    endpoint = "obs.eu-de.otc.t-systems.com"
    skip_region_validation = true
    skip_credentials_validation = true
  }
}