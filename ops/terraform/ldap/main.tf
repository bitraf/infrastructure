# Tokens are configured by .settings.sh
terraform {
  backend "s3" {
    bucket                      = "bitraf-terraform"
    key                         = "ldap/terraform.tfstate"
    region                      = "eu-central-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "eu-central-1.linodeobjects.com"
  }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}
