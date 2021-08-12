# Tokens are configured by .settings.sh
terraform {
  backend "s3" {
    bucket                      = "bitraf-terraform"
    key                         = "p2k16-staging-db/terraform.tfstate"
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

data "terraform_remote_state" "linode" {
  backend = "s3"

  config = {
    bucket                      = "bitraf-terraform"
    key                         = "linode/terraform.tfstate"
    region                      = "eu-central-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "eu-central-1.linodeobjects.com"
  }
}

module "p2k16-staging" {
  source            = "../modules/p2k16-db"
  postgres_password = data.terraform_remote_state.linode.outputs.p2k16_staging.postgres_password
  host              = "p2k16-staging.lan.bitraf.no"
  env               = "staging"
}

module "terraform-output" {
  source = "../modules/terraform-output"
  name   = "p2k16-staging-db"
  public = module.p2k16-staging.public
  vault  = module.p2k16-staging.vault
}
