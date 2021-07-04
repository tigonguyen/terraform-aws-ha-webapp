variable "vpc_id" {
  type = string
  description = "(Required) Related VPC id"
}

variable "env" {
  type = string
  description = "(Required) Environment tagging"
}

variable "internet_gateway_id" {
  type = string
  description = "(Required) The VPC Internet Gateway"
}

variable "nat_gateway_id_a" {
  type = string
  description = "(Required) The Public NAT gateway A"
}

variable "nat_gateway_id_b" {
  type = string
  description = "(Required) The Public NAT gateway B"
}

variable "public_a_id" {
  type = string
  description = "(Required) ID of subnet public A"
}

variable "public_b_id" {
  type = string
  description = "(Required) ID of subnet public B"
}

variable "app_a_id" {
  type = string
  description = "(Required) ID of subnet app A"
}

variable "app_b_id" {
  type = string
  description = "(Required) ID of subnet app B"
}