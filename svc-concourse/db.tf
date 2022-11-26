# These could made proper variables if you would want to change them locally.

locals {
  host = "bite.lan.bitraf.no"
  port = "5413"
}

data "terraform_remote_state" "pdb" {
  backend = "s3"

  config = {
    bucket                      = "bitraf-terraform"
    key                         = "pdb/terraform.tfstate"
    region                      = "eu-central-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "eu-central-1.linodeobjects.com"
  }
}

provider "postgresql" {
  host            = local.host
  port            = local.port
  database        = "postgres"
  username        = "postgres"
  password        = data.terraform_remote_state.pdb.outputs.pdb-bite-13_vault.pdb_postgres_password
  sslmode         = "require"
  connect_timeout = 15
}

resource "random_uuid" "concourse_password" {
}

resource "postgresql_role" "concourse" {
  name     = "concourse"
  password = random_uuid.concourse_password.result
  login    = true
}

resource "postgresql_database" "concourse" {
  name  = "concourse"
  owner = postgresql_role.concourse.name
}
