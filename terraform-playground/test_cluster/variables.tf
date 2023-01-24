module environment {
    source = "../../modules/environment"
}

locals {
    stage_name = "tf-nahian"
    vpc_name = "tf-nahian-vpc"
    vpc_cidr = "192.168.0.0/16"
    subnet_name = "tf-nahian-subnet"
    subnet_cidr = "192.168.1.0/24"
    vpc_subnet_gateway_ip = "192.168.1.1"
    cluster_flavor_id = "cce.s1.small"
    node_spec_default = "s3.large.4"
    otc_domain_name = "OTC00000000001000000447"
    otc_tenant_name = "eu-de_demo"
    node_spec = {
        1 = local.node_spec_default
        #s2 = local.node_spec_default
    }
    cluster_node_count = "2"
    region = "eu-de"
    availability_zone = "eu-de-03"
}
/* variable "token" {
    default = "MIIFtQYJKoZIhvcNAQcCoIIFpjCCBaICAQExDTALBglghkgBZQMEAgEwggM6BgkqhkiG9w0BBwGgggMrBIIDJ3sidG9rZW4iOnsiZXhwaXJlc19hdCI6IjIwMjMtMDEtMTRUMTM6MTU6NDMuNzI3MDAwWiIsIm1ldGhvZHMiOlsicGFzc3dvcmQiXSwiY2F0YWxvZyI6W10sInJvbGVzIjpbeyJuYW1lIjoidGVfYWRtaW4iLCJpZCI6IjAifSx7Im5hbWUiOiJvcF9nYXRlZF9jY2Vfc3dpdGNoIiwiaWQiOiIwIn0seyJuYW1lIjoib3BfZ2F0ZWRfbXVsdGlfYmluZCIsImlkIjoiMCJ9LHsibmFtZSI6Im9wX2dhdGVkX2VwcyIsImlkIjoiMCJ9LHsibmFtZSI6Im9wX2dhdGVkX3RyYXVydXNfbWNzIiwiaWQiOiIwIn0seyJuYW1lIjoib3BfZ2F0ZWRfZXZzX2Vzc2QiLCJpZCI6IjAifV0sInByb2plY3QiOnsiZG9tYWluIjp7Inhkb21haW5fdHlwZSI6IlRTSSIsIm5hbWUiOiJPVEMwMDAwMDAwMDAwMTAwMDAwMDQ0NyIsImlkIjoiZmFmNzJlODUxYzFlNDgzMTkyOTZmMTgxODE4ZjE3NmEiLCJ4ZG9tYWluX2lkIjoiMDAwMDAwMDAwMDEwMDAwMDA0NDcifSwibmFtZSI6ImV1LWRlX2RlbW8iLCJpZCI6IjQyMjI1YmNlZmMzMzQwYzY4MjYyZWVkM2E5NTM0ZGM4In0sImlzc3VlZF9hdCI6IjIwMjMtMDEtMTNUMTM6MTU6NDMuNzI3MDAwWiIsInVzZXIiOnsiZG9tYWluIjp7Inhkb21haW5fdHlwZSI6IlRTSSIsIm5hbWUiOiJPVEMwMDAwMDAwMDAwMTAwMDAwMDQ0NyIsImlkIjoiZmFmNzJlODUxYzFlNDgzMTkyOTZmMTgxODE4ZjE3NmEiLCJ4ZG9tYWluX2lkIjoiMDAwMDAwMDAwMDEwMDAwMDA0NDcifSwibmFtZSI6Im5haGlhbiIsInBhc3N3b3JkX2V4cGlyZXNfYXQiOiIiLCJpZCI6ImQyMGJlNDNmYjA5ZTQ5MzdhODFmOGNkZWJlMTg1MThjIn19fTGCAk4wggJKAgEBMIGkMIGWMQswCQYDVQQGEwJERTEMMAoGA1UECAwDTlJXMQ0wCwYDVQQHDARCb25uMRwwGgYDVQQKDBNEZXV0c2NoZSBUZWxla29tIEFHMTcwNQYDVQQLDC5ULVN5c3RlbXMgUFUgUHVibGljIENsb3VkIC0gT3BlbiBUZWxla29tIENsb3VkMRMwEQYDVQQDDApjYS5pYW0ucGtpAgkAi0NlULiz2iIwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBgFduzge9tJX8j4TMspomyC-IhYuWvoqflIxoRBCuXvP7neLLT9dhAgV41zy-hG-QTnXuYB-+II3lSiblDuyZq6D14F4W9AmZrSXttn3y1Ymbjpj-QCrePeBG81hUUmXr08aULLJa4+Pk2pgU6yGd1QoaHE026GoTdqY6Yu-efGOOD4NvPZz9bncmoS4CLmLfX0kBPg2XiodfhtnxFiUf4W24l1JC4Z06PwMcLWiftAFN-72NpzL55L0bsIuxYrMDKNCT7KJnkDcnuWD7SZA4SradI+Po-BwTzJq2AUhzbrY1x+L4fktb2F8OU6b5eZnXzlpCWMqQz4BJ3T4k7UTWxsEhfLXjQPqBvFG+q1CQJzn44Hrqskh9K3kJNrebLAECLuziJSiCi8mW9CoVXsJLAA4sHH0y2rq7pQDk19RkCZBZZjljXBcW6W4g2V+P12aRfNbagQ8BLR-JHjh9CEzGevDJM-ygYHS7eQ4YK+jhEPm293f9zEBCsBqzr1UT1m4eiQ=="
  
} */