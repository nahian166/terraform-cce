/* locals {
    buckets = toset([
        "tfstate.${var.stage_name}.state"
    ])
} */
resource "opentelekomcloud_s3_bucket" "tf_remote_state" {
  #for_each = local.buckets
  bucket = "nahian-tfstate-bucket"
  acl    = "private"
  region = "eu-de"
  versioning {
    enabled = true
  }
}

/* resource "opentelekomcloud_compute_instance_v2" "webserver" {
  count       = var.instance_count
  name        = "${var.project}-webserver${format("%02d", count.index + 1)}"
  image_name  = var.image_name
  flavor_name = var.flavor_name
  key_pair    = opentelekomcloud_compute_keypair_v2.keypair.name
  security_groups = [
    opentelekomcloud_compute_secgroup_v2.secgrp_web.name
  ]

  network {
    uuid = opentelekomcloud_networking_network_v2.network.id
  }
  tags = ["foo.bar", "tag.value"]
} */