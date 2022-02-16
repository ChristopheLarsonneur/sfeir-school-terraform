variable "servers" {
  description = "Hash of servers to create"
}

variable "environmment" {
  type = string
  description = "Environment to deploy"
}

variable "server_prefix" {
  type = string
  description = "servers prefix name"
}