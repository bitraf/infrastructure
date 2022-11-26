# Tokens are configured by .settings.sh
terraform {
  required_version = "~> 1.3.5"

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
    healthchecksio = {
      source  = "kristofferahl/healthchecksio"
      version = "1.9.0"
    }
    linode = {
      source  = "linode/linode"
      version = "1.20.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    shell = {
      source  = "scottwinkler/shell"
      version = "1.7.10"
    }
  }
}

provider "healthchecksio" {
  api_key = var.pdb_project_api_key
  api_url = "https://healthchecks.bitraf.no/api/v1"
}

data "healthchecksio_channel" "slack" {
  kind = "slack"
}
