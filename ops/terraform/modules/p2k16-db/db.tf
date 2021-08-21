resource "postgresql_role" "p2k16" {
  name  = "p2k16"
  login = false
}

resource "postgresql_database" "p2k16" {
  name  = "p2k16"
  owner = postgresql_role.p2k16.name
}

# User: p2k16-web

resource "postgresql_role" "web" {
  name     = "p2k16-web"
  login    = true
  password = random_uuid.web_password.result
}

resource "random_uuid" "web_password" {
}

# User: p2k16-flyway

resource "postgresql_role" "flyway" {
  name     = "p2k16-flyway"
  login    = true
  password = random_uuid.flyway_password.result
}

resource "random_uuid" "flyway_password" {
}

# User: p2k16-ldap

resource "postgresql_role" "ldap" {
  name     = "p2k16-ldap"
  login    = true
  password = random_uuid.ldap_password.result
}

resource "random_uuid" "ldap_password" {
}

# User: stripestats

resource "postgresql_role" "stripestats" {
  name     = "stripestats"
  login    = true
  password = random_uuid.stripestats_password.result
}

resource "random_uuid" "stripestats_password" {
}
