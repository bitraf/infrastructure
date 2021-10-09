module "prod" {
  source = "./ldap-instance"

  ldap_instance = "prod"
  ldap_base_dn = "dc=bitraf,dc=no"
}

output prod {
  value = module.test.instance
}
