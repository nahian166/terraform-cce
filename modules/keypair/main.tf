terraform {
  required_providers {
    opentelekomcloud = {
        source = "opentelekomcloud/opentelekomcloud"
        version = "1.32.0"
    }
  }
}
# RSA key of size 4096 bits
resource "tls_private_key" "rsa-nahian-keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "opentelekomcloud_compute_keypair_v2" "nahian-keypair" {
  #count      = var.instance_count
  name       = "nahian-keypair"
  #public_key = file(var.ssh_pub_key)
  public_key = tls_private_key.rsa-nahian-keypair.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "../../${opentelekomcloud_compute_keypair_v2.nahian-keypair.name}.pem"
  content = tls_private_key.rsa-nahian-keypair.private_key_pem
}

output "keypair_name" {
    value = opentelekomcloud_compute_keypair_v2.nahian-keypair.name
}

output "key_pair_id" {
    value = opentelekomcloud_compute_keypair_v2.nahian-keypair.id
}

