module "terraform-output" {
  source = "../../../ops/terraform/modules/terraform-output"
  name   = "ldap-${var.ldap_instance}"
  public = {
    p2k16_web_username = local.p2k16_web_dn
  }
  vault = {
    p2k16_web_password = random_uuid.p2k16-web.result
  }
}
