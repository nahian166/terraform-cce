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