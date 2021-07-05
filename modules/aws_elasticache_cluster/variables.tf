variable "env" {
  type = string
  description = "(Required) Environment tagging"
}

variable "region" {
  type = string
  description = "(Required) Region where subnets located"
}

variable "cache_subnet_group_name" {
  type = string
  description = "(Required) Cache Subnet group name"
}

variable "cache_sg_id" {
  type = string
  description = "(Required) id of the Cache SG" 
}