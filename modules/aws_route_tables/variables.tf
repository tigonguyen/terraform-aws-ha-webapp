variable "vpc_id" {
  type = string
  description = "(Required) Related VPC id"
}

variable "env" {
  type = string
  description = "(Required) Environment tagging"
}

variable "gateway_id" {
  type = string
  description = "(Required) The VPC Internet Gateway"
}

variable "public_a_id" {
  type = string
  description = "(Required) ID of subnet public A"
}

variable "public_b_id" {
  type = string
  description = "(Required) ID of subnet public B"
}