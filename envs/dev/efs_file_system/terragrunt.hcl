############ Terragrunt section #############
# Get configuration from root directory
include {
    path = find_in_parent_folders()
}

############ Terraform section ##############
# Use remote module for configuration
terraform {
  source = "../../../modules/aws_efs_file_system"
}

# Collect values from env_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

# Define dependencies on other modules
dependency "security_groups" {
  config_path = "../security_groups"
}
dependency "subnets" {
  config_path = "../subnets"
}

# Pass data into remote module with inputs
inputs = {
  app_a_id = dependency.subnets.outputs.app_a_id
  app_b_id = dependency.subnets.outputs.app_b_id
  fs_sg_id = dependency.security_groups.outputs.fs_sg_id
  env      = local.env_vars.env
}
