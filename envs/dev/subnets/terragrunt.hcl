############ Terragrunt section #############
# Get configuration from root directory
include {
    path = find_in_parent_folders()
}

############ Terraform section ##############
# Use remote module for configuration
terraform {
  source = "../../../modules/aws_subnets"
}

# Collect values from env_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

# Define dependencies on other modules
dependency "vpc" {
  config_path = "../vpc"
}

# Pass data into remote module with inputs
inputs = {
  vpc_id        = dependency.vpc.outputs.vpc_id
  env           = local.env_vars.env
  region        = local.env_vars.region
  cidr_public_a = local.env_vars.subnets_cidr.public_a
  cidr_public_b = local.env_vars.subnets_cidr.public_b
  cidr_app_a    = local.env_vars.subnets_cidr.app_a
  cidr_app_b    = local.env_vars.subnets_cidr.app_b
  cidr_data_a   = local.env_vars.subnets_cidr.data_a
  cidr_data_b   = local.env_vars.subnets_cidr.data_b
}
