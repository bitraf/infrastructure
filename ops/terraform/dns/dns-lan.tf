data "shell_script" "host_database" {
  lifecycle_commands {
    read = <<-EOF
          ${path.module}/generate-host-database
          EOF
  }
  environment = {
    FILE = "${path.module}/../../../group_vars/all/host_database.yml"
  }
}

locals {
  host_database = { for name, value in data.shell_script.host_database.output : name => jsondecode(value) }
}

resource "linode_domain_record" "lan-a-records" {
  for_each = local.host_database

  domain_id   = linode_domain.bitraf.id
  name        = each.value.name
  record_type = each.value.type
  target      = each.value.target
}
