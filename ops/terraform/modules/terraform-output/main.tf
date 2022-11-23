terraform {
  required_providers {
    shell = {
      source  = "scottwinkler/shell"
      version = "1.7.10"
    }
  }
}

resource "shell_script" "files" {
  lifecycle_commands {
    create = <<-EOF
      mkdir -p "$DIR"
      echo "$PUBLIC" | (command -v jq > /dev/null && jq . || cat -) > "$PUBLIC_FILE"
      echo "$VAULT" | (command -v jq > /dev/null && jq . || cat -) | ansible-vault encrypt --output "$VAULT_FILE" -
      EOF
    update = <<-EOF
      mkdir -p "$DIR"
      echo "$PUBLIC" | (command -v jq > /dev/null && jq . || cat -) > "$PUBLIC_FILE"
      echo "$VAULT" | (command -v jq > /dev/null && jq . || cat -) | ansible-vault encrypt --output "$VAULT_FILE" -

      echo "{\"public\":"
      cat "$PUBLIC_FILE"
      echo ", \"vault\": "
      ansible-vault view "$VAULT_FILE"
      echo "}"
      EOF
    delete = <<-EOF
      rm -rf "$DIR"
      EOF
    read   = <<-EOF
      echo "{\"public\":"
      cat "$PUBLIC_FILE"
      echo ", \"vault\": "
      ansible-vault view "$VAULT_FILE"
      echo "}"
      EOF
  }
  environment = {
    DIR         = format("../../../terraform-output/%s", var.name)
    PUBLIC      = jsonencode(var.public)
    PUBLIC_FILE = format("../../../terraform-output/%s/public.json", var.name)
    VAULT       = jsonencode(var.vault)
    VAULT_FILE  = format("../../../terraform-output/%s/vault.json", var.name)
  }

  working_directory = path.module
}

variable "name" {
  type = string
}

variable "public" {
}

variable "vault" {
}
