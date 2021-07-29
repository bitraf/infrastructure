variable "env" {
  type = string
}

variable "host" {
  type = string
}

variable "port" {
  type    = number
  default = 5432
}

variable "postgres_password" {
  type      = string
  sensitive = true
}
