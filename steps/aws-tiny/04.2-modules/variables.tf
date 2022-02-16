variable "server_prefix" {
  type = string
  default = "Example"
}

variable "environment" {
  type = string
  default = "dev"
  description = "Environment to deploy"
}

variable "instance_type" {
  type = string
  default = "t2.small"
}