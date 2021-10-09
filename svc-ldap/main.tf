terraform {
  required_providers {
    ldap = {
      source  = "trevex/ldap"
      version = "0.5.1"
    }
  }
}

provider "ldap" {
  alias = "test"

  url           = "ldap://p2k16-staging.bitraf.no"
  bind_user     = "cn=admin,dc=test,dc=bitraf,dc=no"
  bind_password = "admin"
}

module "ldap" {
  source = "./tf/ldap"
  providers = {
    ldap = ldap.test
  }

  ldap_instance = "test"
  base_dn       = "dc=test,dc=bitraf,dc=no"
}
