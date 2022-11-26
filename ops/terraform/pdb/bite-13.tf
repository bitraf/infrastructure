resource "random_uuid" "bite-13-postgres_password" {
}

module "bite-13" {
  source = "../modules/pdb-bucket"

  key               = "bite-13"
  postgres_password = random_uuid.bite-13-postgres_password.result
}

module "terraform-output-bite-13" {
  source = "../modules/terraform-output"
  name   = "pdb/bite-13"
  public = module.bite-13.pdb_config_public
  vault = merge(
    module.bite-13.pdb_config_vault, {
      ping_url_wal : healthchecksio_check.bite-13-wal.ping_url
      ping_url_backup : healthchecksio_check.bite-13-backup.ping_url
  })
}

output "pdb-bite-13_public" {
  value = module.bite-13.pdb_config_public
}

output "pdb-bite-13_vault" {
  value     = module.bite-13.pdb_config_vault
  sensitive = true
}

resource "healthchecksio_check" "bite-13-wal" {
  name = "bite-13-wal"

  grace    = 60 * 60
  timeout  = 24 * 60 * 60

  channels = [
    data.healthchecksio_channel.slack.id,
  ]
}

resource "healthchecksio_check" "bite-13-backup" {
  name = "bite-13-backup"

  grace    = 60 * 60
  schedule = "45 03 * * *" # should match shared-roles/pdb/templates/crontab
  timezone = "Europe/Oslo"

  channels = [
    data.healthchecksio_channel.slack.id,
  ]
}
