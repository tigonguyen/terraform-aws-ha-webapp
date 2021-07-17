variable "efs_dns_name" {
  type = string
  description = "(Required) EFS's DNS hostname"
}

variable "write_instance_dns" {
  type = string
  description = "(Required) DB's DNS hostname"
}

variable "lb_dns_name" {
  type = string
  description = "(Required) LB's DNS hostname"
}

variable "db_client_sg_id" {
  type = string
  description = "(Required) id of the DB client SG" 
}

variable "fs_client_sg_id" {
  type = string
  description = "(Required) id of the FS client SG" 
}

variable "cache_client_sg_id" {
  type = string
  description = "(Required) id of the Cache client SG" 
}

variable "wp_sg_id" {
  type = string
  description = "(Required) id of the WP Server SG" 
}