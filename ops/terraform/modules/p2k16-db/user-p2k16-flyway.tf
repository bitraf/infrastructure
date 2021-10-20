resource "postgresql_role" "flyway" {
  name     = "p2k16-flyway"
  login    = true
  password = random_uuid.flyway_password.result
}

resource "random_uuid" "flyway_password" {
}

resource "postgresql_grant" "flyway_schema" {
  database    = postgresql_database.p2k16.name
  role        = postgresql_role.flyway.name
  schema      = "public"
  object_type = "schema"
  privileges  = [
    "CREATE",
    "USAGE",
  ]
}

resource "postgresql_grant" "flyway_tables" {
  database    = postgresql_database.p2k16.name
  role        = postgresql_role.flyway.name
  schema      = "public"
  object_type = "table"
  privileges  = [
    "DELETE",
    "INSERT",
    "REFERENCES",
    "SELECT",
    "TRIGGER",
    "TRUNCATE",
    "UPDATE",
  ]
}
