terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
    }
  }
}

resource random_uuid admin {
}

resource random_uuid config {
}

locals {
  public = {
    ldap_instance: var.ldap_instance
    ldap_domain: replace(replace(var.ldap_base_dn, ",dc=", "."), "dc=", "")
    ldap_base_dn: var.ldap_base_dn
    ldap_admin_dn: format("cn=admin,%s", var.ldap_base_dn)
    ldap_config_dn: format("cn=admin,cn=config", var.ldap_base_dn)
  }
  vault = {
    ldap_admin_password: random_uuid.admin.result # TODO: apply sensitive()
    ldap_config_password: random_uuid.config.result # TODO: apply sensitive()
  }
}

module output {
  source = "../../modules/terraform-output"
  name   = format("ldap/%s", var.ldap_instance)
  public = local.public
  vault  = local.vault
}

output instance {
  value = merge(local.public, local.vault)
}
