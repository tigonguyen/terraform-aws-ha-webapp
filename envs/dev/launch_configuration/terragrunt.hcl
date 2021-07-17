############ Terragrunt section #############
# Get configuration from root directory
include {
    path = find_in_parent_folders()
}

############ Terraform section ##############
# Use remote module for configuration
terraform {
  source = "../../../modules/aws_launch_configuration"
}

# Collect values from env_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

# Define dependencies on other modules
dependency "security_groups" {
  config_path = "../security_groups"
}
dependency "lb" {
  config_path = "../lb"
}
dependency "efs_file_system" {
  config_path = "../efs_file_system"
}
dependency "rds_cluster" {
  config_path = "../rds_cluster"
}

# Pass data into remote module with inputs
inputs = {
  wp_sg_id           = dependency.security_groups.outputs.wp_sg_id
  db_client_sg_id    = dependency.security_groups.outputs.db_client_sg_id
  fs_client_sg_id    = dependency.security_groups.outputs.fs_client_sg_id
  cache_client_sg_id = dependency.security_groups.outputs.cache_client_sg_id
  efs_dns_name       = dependency.efs_file_system.outputs.efs_dns_name
  write_instance_dns = dependency.rds_cluster.outputs.write_instance_dns
  lb_dns_name        = dependency.lb.outputs.lb_dns_name
}
