terraform {
  required_providers {
    opentelekomcloud = {
        source = "opentelekomcloud/opentelekomcloud"
        version = "1.32.0"
    }
  }
}

# bucket is required to store tracing logs
resource "opentelekomcloud_s3_bucket" "cloud_tracing_service" {
    bucket          = var.bucket_name
    acl             = "private"
    region          = "eu-de"
    force_destroy   = true 
    versioning {
        enabled = false
    }
    lifecycle_rule {
      enabled = true
      expiration {
            days = 180
        }
    }
}

resource "opentelekomcloud_cts_tracker_v1" "cloud_tracing_service_tracker_v1" {
    bucket_name         = var.bucket_name
    file_prefix_name    = var.file_prefix
    #status              = "enabled"
    #is_send_all_key_operation = false
    #is_support_smn = false
    #operations          = []
    #topic_id            = ""
}

