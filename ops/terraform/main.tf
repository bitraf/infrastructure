# Tokens are configured by .settings.sh
terraform {
  backend "s3" {
    bucket                      = "bitraf-terraform"
    key                         = "root/terraform.tfstate"
    region                      = "eu-central-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "eu-central-1.linodeobjects.com"
  }

  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.13.4"
    }

    minio = {
      source  = "aminueza/minio"
      version = "1.2.0"
    }
  }
}

provider "minio" {
  minio_server = "bite.bitraf.no:9000"
  #  minio_ssl = "true"
  minio_access_key = var.minio_access_key
  minio_secret_key = var.minio_secret_key
}

variable "minio_access_key" {
  type = string
}

variable "minio_secret_key" {
  type = string
}

module "dns" {
  source = "./dns"
}
