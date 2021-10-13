module "terraform-output" {
  source = "../../../ops/terraform/modules/terraform-output"
  name   = "svc-p2k16/ldap/${var.ldap_instance}"
  public = {
    ldap_p2k16_web_dn = local.p2k16_web_dn
    ldap_url = var.ldap_url
    ldap_base_dn = var.base_dn
  }
  vault = {
    ldap_p2k16_web_password = random_uuid.p2k16-web.result
  }
}
