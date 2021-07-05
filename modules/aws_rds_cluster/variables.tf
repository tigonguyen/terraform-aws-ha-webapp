variable "env" {
  type = string
  description = "(Required) Environment tagging"
}

variable "region" {
  type = string
  description = "(Required) Region where subnets located"
}

variable "db_subnet_group_name" {
  type = string
  description = "(Required) DB Subnet group name"
}

variable "db_sg_id" {
  type = string
  description = "(Required) id of the DB SG" 
}