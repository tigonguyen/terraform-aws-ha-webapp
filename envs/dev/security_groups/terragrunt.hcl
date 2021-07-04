############ Terragrunt section #############
# Get configuration from root directory
include {
    path = find_in_parent_folders()
}

############ Terraform section ##############
# Use remote module for configuration
terraform {
  source = "../../../modules/aws_security_groups"
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
  vpc_id = dependency.vpc.outputs.vpc_id
  env    = local.env_vars.env
}
