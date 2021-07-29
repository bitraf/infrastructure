resource "random_uuid" "bite-10-postgres_password" {
}

module "bite-10" {
  source = "../modules/pdb-bucket"

  key = "pdb-10"
  postgres_password = random_uuid.bite-10-postgres_password.result
}

module "terraform-output-pdb-10" {
  source = "../modules/terraform-output"
  name   = "pdb/pdb-10"
  public = module.bite-10.pdb_config_public
  vault = module.bite-10.pdb_config_vault
}

resource "random_uuid" "bite-13-postgres_password" {
}

module "bite-13" {
  source = "../modules/pdb-bucket"

  key = "pdb-13"
  postgres_password = random_uuid.bite-13-postgres_password.result
}

module "terraform-output-pdb-13" {
  source = "../modules/terraform-output"
  name   = "pdb/pdb-13"
  public = module.bite-13.pdb_config_public
  vault = module.bite-13.pdb_config_vault
}

#
# p2k16-prod
#

resource "random_uuid" "p2k16-prod-postgres_password" {
}

module "pdb-p2k16-prod" {
  source = "../modules/pdb-bucket"

  key = "pdb-p2k16-prod"
  postgres_password = random_uuid.p2k16-prod-postgres_password.result
}

module "terraform-output-pdb-p2k16-prod" {
  source = "../modules/terraform-output"
  name   = "pdb/pdb-p2k16-prod"
  public = module.pdb-p2k16-prod.pdb_config_public
  vault = module.pdb-p2k16-prod.pdb_config_vault
}

#
# p2k16-staging
#

resource "random_uuid" "p2k16-staging-postgres_password" {
}

module "pdb-p2k16-staging" {
  source = "../modules/pdb-bucket"

  key = "pdb-p2k16-staging"
  postgres_password = random_uuid.p2k16-staging-postgres_password.result
}

module "terraform-output-pdb-p2k16-staging" {
  source = "../modules/terraform-output"
  name   = "pdb/pdb-p2k16-staging"
  public = module.pdb-p2k16-staging.pdb_config_public
  vault = module.pdb-p2k16-staging.pdb_config_vault
}
