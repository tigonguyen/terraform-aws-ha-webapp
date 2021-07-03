variable "vpc_cidr" {
  type = string
  description = "(Required) IP range for the VPC"
}

variable "env" {
  type = string
  description = "(Required) Environment tagging"
}