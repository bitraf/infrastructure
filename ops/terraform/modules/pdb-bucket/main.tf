terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.20.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

data "linode_object_storage_cluster" "primary" {
  id = "eu-central-1"
}

resource "random_uuid" "bucket" {
}

resource "linode_object_storage_bucket" "bucket" {
  cluster = data.linode_object_storage_cluster.primary.id
  label   = format("%s-%s", var.key, random_uuid.bucket.result)
}

resource "linode_object_storage_key" "sender-key" {
  label = format("%s-sender", var.key)
  bucket_access {
    cluster     = linode_object_storage_bucket.bucket.cluster
    bucket_name = linode_object_storage_bucket.bucket.label
    permissions = "read_write"
  }
}

output "pdb_config_public" {
  value = {
    pdb_bucket          = linode_object_storage_bucket.bucket.label
    pdb_bucket_cluster  = linode_object_storage_bucket.bucket.cluster
    pdb_bucket_endpoint = format("https://%s.linodeobjects.com", linode_object_storage_bucket.bucket.cluster)
  }
}

output "pdb_config_vault" {
  sensitive = true
  value = {
    pdb_bucket_sender_access_key = linode_object_storage_key.sender-key.access_key
    pdb_bucket_sender_secret_key = linode_object_storage_key.sender-key.secret_key
    pdb_postgres_password        = var.postgres_password
  }
}
