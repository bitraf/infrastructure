terraform {
  required_providers {
    postgresql = {
      source = "cyrilgdn/postgresql"
    }
  }
}

provider "postgresql" {
  host            = var.host
  port            = var.port
  database        = "postgres"
  username        = "postgres"
  password        = var.postgres_password
  sslmode         = "require"
  connect_timeout = 15
}

output "public" {
  value = {
    db_host     = var.host
    db_port     = var.port
    db_database = postgresql_database.p2k16.name

    db_owner_username  = postgresql_role.p2k16.name
    db_web_username    = postgresql_role.web.name
    db_flyway_username = postgresql_role.flyway.name
  }
}

output "vault" {
  value = {
    db_web_password    = postgresql_role.web.password
    db_flyway_password = postgresql_role.flyway.password
  }
}
