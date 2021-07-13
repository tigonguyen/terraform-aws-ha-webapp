variable "vpc_id" {
  type = string
  description = "(Required) Related VPC id"
}

variable "env" {
  type = string
  description = "(Required) Environment tagging"
}

variable "app_a_id" {
  type = string
  description = "(Required) ID of subnet app A"
}

variable "app_b_id" {
  type = string
  description = "(Required) ID of subnet app B"
}

variable "lb_sg_id" {
  type = string
  description = "(Required) id of the FS SG" 
}