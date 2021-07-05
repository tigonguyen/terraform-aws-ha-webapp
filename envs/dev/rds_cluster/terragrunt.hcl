############ Terragrunt section #############
# Get configuration from root directory
include {
    path = find_in_parent_folders()
}

############ Terraform section ##############
# Use remote module for configuration
terraform {
  source = "../../../modules/aws_rds_cluster"
}

# Collect values from env_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

# Define dependencies on other modules
dependency "security_groups" {
  config_path = "../security_groups"
}
dependency "db_subnet_group" {
  config_path = "../db_subnet_group"
}

# Pass data into remote module with inputs
inputs = {
  db_subnet_group_name = dependency.db_subnet_group.outputs.db_subnet_group_name
  db_sg_id             = dependency.security_groups.outputs.db_sg_id
  env                  = local.env_vars.env
  region               = local.env_vars.region
}
