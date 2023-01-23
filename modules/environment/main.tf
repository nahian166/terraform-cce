terraform {
  required_providers {
    opentelekomcloud = {
        source = "opentelekomcloud/opentelekomcloud"
        version = "1.32.0"
    }
  }
}

data "external" "environment_variables" {
    program = split(" ", "jq -n env")
}

output "variable" {
    sensitive = true
    value = data.external.environment_variables.result
}
