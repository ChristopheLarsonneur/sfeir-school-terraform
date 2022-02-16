variable "servers" {
  description = "Hash of servers to create"
}

variable "instance_type" {
  type = string
  description = "Instance types"
}

variable "environmment" {
  type = string
  description = "Environment to deploy"
}