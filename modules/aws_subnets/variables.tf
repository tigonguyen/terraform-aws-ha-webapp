variable "vpc_id" {
  type = string
  description = "(Required) Related VPC id"
}

variable "region" {
  type = string
  description = "(Required) Region where subnets located"
}

variable "env" {
  type = string
  description = "(Required) Environment tagging"
}

variable "cidr_public_a" {
  type = string
  description = "(Required) IP range for the subnet public A"
}

variable "cidr_public_b" {
  type = string
  description = "(Required) IP range for the subnet public B"
}

variable "cidr_app_a" {
  type = string
  description = "(Required) IP range for the subnet Application A"
}

variable "cidr_app_b" {
  type = string
  description = "(Required) IP range for the subnet Application B"
}

variable "cidr_data_a" {
  type = string
  description = "(Required) IP range for the subnet Data A"
}

variable "cidr_data_b" {
  type = string
  description = "(Required) IP range for the subnet Data B"
}