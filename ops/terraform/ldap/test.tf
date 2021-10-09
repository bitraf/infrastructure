module "test" {
  source = "./ldap-instance"

  ldap_instance = "test"
  ldap_base_dn = "dc=test,dc=bitraf,dc=no"
}

output test {
  value = module.test.instance
#  value = {
#    public = module.test.public
#    vault  = module.test.vault
#  }
}
