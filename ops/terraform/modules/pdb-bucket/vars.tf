variable "key" {
  type = string
}

variable "postgres_password" {
  type      = string
  sensitive = true
}
