############ Terragrunt section #############
# Get configuration from root directory
include {
    path = find_in_parent_folders()
}

############ Terraform section ##############
# Use remote module for configuration
terraform {
  source = "../../../modules/aws_subnet_groups"
}

# Collect values from env_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

# Define dependencies on other modules
dependency "subnets" {
  config_path = "../subnets"
}

# Pass data into remote module with inputs
inputs = {
  data_a_id = dependency.subnets.outputs.data_a_id
  data_b_id = dependency.subnets.outputs.data_b_id
  env       = local.env_vars.env
}
