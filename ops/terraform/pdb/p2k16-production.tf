resource "random_uuid" "p2k16-production-postgres_password" {
}

module "pdb-p2k16-production" {
  source = "../modules/pdb-bucket"

  key               = "pdb-p2k16-production"
  postgres_password = random_uuid.p2k16-production-postgres_password.result
}

module "terraform-output-pdb-p2k16-production" {
  source = "../modules/terraform-output"
  name   = "pdb/pdb-p2k16-production"
  public = module.pdb-p2k16-production.pdb_config_public
  vault  = module.pdb-p2k16-production.pdb_config_vault
}

output "pdb-p2k16-production_public" {
  value = module.pdb-p2k16-production.pdb_config_public
}

output "pdb-p2k16-production_vault" {
  value     = module.pdb-p2k16-production.pdb_config_vault
  sensitive = true
}
