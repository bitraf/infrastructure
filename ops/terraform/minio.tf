module "pg-backup-bite" {
  source = "./modules/pg-backup"
  id     = "bite"
}

output "pg_backup_bite" {
  value = {
    sender : module.pg-backup-bite.sender,
    bucket : module.pg-backup-bite.bucket,
  }
}
