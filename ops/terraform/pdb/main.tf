# Tokens are configured by .settings.sh
terraform {
  backend "s3" {
    bucket                      = "bitraf-terraform"
    key                         = "pdb/terraform.tfstate"
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
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    shell = {
      source  = "scottwinkler/shell"
      version = "1.7.7"
    }
  }
}

