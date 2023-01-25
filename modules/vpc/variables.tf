/* variable "region" {
} */

variable "vpc_name" {
  #default = "nahian-test-vpc"
}

variable "vpc_cidr" {
  #default = "192.168.0.0/16"
}

variable "subnet_name" {
  #default = "nahian-test-vpc"
}

variable "subnet_cidr" {
/*   description = "Sub Network CIDR"
  default     = "192.168.1.0/24" */
}


variable "subnet_gateway_ip" {
/*   description = "Subnet Gateway"
  default     = "192.168.1.1" */
}

variable "dns_config" {
  type        = list(string)
  description = "Common Domain Name Server list for all subnets"
  default = [
    "100.125.4.25",
    #"100.125.129.199",
    "8.8.8.8"
  ]
}