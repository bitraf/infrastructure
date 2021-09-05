resource "linode_user" "itavdelingen" {
  username   = "itavdelingenbitraf"
  email      = "itavdelingen@bitraf.no"
  restricted = true

  domain_grant {
    id          = linode_domain.bitraf.id
    permissions = "read_write"
  }
}
