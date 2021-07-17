variable "env" {
  type = string
  description = "(Required) Environment tagging"
}

variable "launch_conf_name" {
  type = string
  description = "(Required) Launch configuration's name"
}

variable "app_a_id" {
  type = string
  description = "(Required) ID of subnet app A"
}

variable "app_b_id" {
  type = string
  description = "(Required) ID of subnet app B"
}

variable "tg_arn" {
  type = string
  description = "(Required) Target group's ARN"
}