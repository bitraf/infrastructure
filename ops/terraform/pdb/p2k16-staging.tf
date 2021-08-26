resource "random_uuid" "p2k16-staging-postgres_password" {
}

module "pdb-p2k16-staging" {
  source = "../modules/pdb-bucket"

  key               = "pdb-p2k16-staging"
  postgres_password = random_uuid.p2k16-staging-postgres_password.result
}

module "terraform-output-pdb-p2k16-staging" {
  source = "../modules/terraform-output"
  name   = "pdb/pdb-p2k16-staging"
  public = module.pdb-p2k16-staging.pdb_config_public
  vault  = module.pdb-p2k16-staging.pdb_config_vault
}

output "pdb-p2k16-staging_public" {
  value = module.pdb-p2k16-staging.pdb_config_public
}

output "pdb-p2k16-staging_vault" {
  value     = module.pdb-p2k16-staging.pdb_config_vault
  sensitive = true
}
