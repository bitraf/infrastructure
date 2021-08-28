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
  vault  = module.bite-13.pdb_config_vault
}

output "pdb-bite-13_public" {
  value = module.bite-13.pdb_config_public
}

output "pdb-bite-13_vault" {
  value     = module.bite-13.pdb_config_vault
  sensitive = true
}
