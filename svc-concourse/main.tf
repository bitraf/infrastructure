# Tokens are configured by .settings.sh
terraform {
  required_version = "~> 1.3.5"

  backend "s3" {
    bucket                      = "bitraf-terraform"
    key                         = "svc-concourse.tfstate"
    region                      = "eu-central-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "eu-central-1.linodeobjects.com"
  }

  required_providers {
    ansiblevault = {
      source  = "MeilleursAgents/ansiblevault"
      version = "2.2.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.23.1"
    }
    linode = {
      source  = "linode/linode"
      version = "1.20.2"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.17.1"
    }
    shell = {
      source  = "scottwinkler/shell"
      version = "1.7.10"
    }
  }
}

provider "docker" {
  host = "ssh://concourse.bitraf.no"
}

provider "ansiblevault" {
  root_folder = ".."
}
