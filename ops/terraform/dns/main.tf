# Tokens are configured by .settings.sh
terraform {
  required_version = "~> 1.3.5"

  backend "s3" {
    bucket                      = "bitraf-terraform"
    key                         = "dns/terraform.tfstate"
    region                      = "eu-central-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "eu-central-1.linodeobjects.com"
  }

  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.20.2"
    }
    shell = {
      source  = "scottwinkler/shell"
      version = "1.7.7"
    }
  }
}

