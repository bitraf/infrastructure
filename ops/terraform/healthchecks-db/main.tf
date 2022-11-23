terraform {
  required_version = "~> 1.3.5"

  backend "s3" {
    bucket                      = "bitraf-terraform"
    key                         = "healthchecks-db/terraform.tfstate"
    region                      = "eu-central-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "eu-central-1.linodeobjects.com"
  }

  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.13.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.1.0"
    }
  }
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

locals {
  host = "bite.lan.bitraf.no"
  port = "5413"
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

resource "postgresql_role" "healtchecks" {
  name     = "healtchecks"
  password = "healtchecks_password"
  login    = true
}

resource "postgresql_database" "healtchecks" {
  name  = "healtchecks"
  owner = postgresql_role.healtchecks.name
}

resource "random_uuid" "healtchecks_password" {
}

module "terraform-output" {
  source = "../modules/terraform-output"
  name   = "healtchecks-db"
  public = {
    db_host     = local.host
    db_port     = local.port
    db_database = postgresql_database.healtchecks.name

    db_username = postgresql_role.healtchecks.name
  }
  vault = {
    db_password = postgresql_role.healtchecks.password
  }
}
