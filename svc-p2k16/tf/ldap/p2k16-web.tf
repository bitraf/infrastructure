resource "random_uuid" "p2k16-web" {
}

locals {
  p2k16_web_dn = format("cn=p2k16-web,%s", var.base_dn)
}

resource "ldap_object" "p2k16-web" {
  dn = local.p2k16_web_dn

  object_classes = [
    "top",
    "person",
  ]

  attributes = [
    { userPassword : random_uuid.p2k16-web.result },
    { sn : "p2k16-web" },
  ]
}

resource "ldap_object_attributes" "foo" {
  dn = format("cn=adminGroup,ou=meta,%s", var.base_dn)

  attributes = [
    { uniqueMember = local.p2k16_web_dn },
  ]
}
