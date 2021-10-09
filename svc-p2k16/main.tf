terraform {
  backend "s3" {
    bucket                      = "bitraf-terraform"
    key                         = "svc-p2k16/terraform.tfstate"
    region                      = "eu-central-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "eu-central-1.linodeobjects.com"
  }

  required_providers {
    ldap = {
      source  = "trevex/ldap"
      version = "0.5.1"
    }
  }
}

data "terraform_remote_state" "ldap" {
  backend = "s3"

  config = {
    bucket                      = "bitraf-terraform"
    key                         = "ldap/terraform.tfstate"
    region                      = "eu-central-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "eu-central-1.linodeobjects.com"
  }
}

locals {
  test = data.terraform_remote_state.ldap.outputs.test
  prod = data.terraform_remote_state.ldap.outputs.prod
}

provider "ldap" {
  alias = "test"

  url           = "ldap://p2k16-staging.bitraf.no"
  bind_user     = local.test.ldap_admin_dn
  bind_password = local.test.ldap_admin_password
}

module "ldap" {
  source = "./tf/ldap"
  providers = {
    ldap = ldap.test
  }

  ldap_instance = local.test.ldap_instance
  base_dn       = local.test.ldap_base_dn
}
