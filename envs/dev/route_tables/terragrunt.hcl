############ Terragrunt section #############
# Get configuration from root directory
include {
    path = find_in_parent_folders()
}

############ Terraform section ##############
# Use remote module for configuration
terraform {
  source = "../../../modules/aws_route_tables"
}

# Collect values from env_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

# Define dependencies on other modules
dependency "vpc" {
  config_path = "../vpc"
}
dependency "internet_gateway" {
  config_path = "../internet_gateway"
}
dependency "subnets" {
  config_path = "../subnets"
}

# Pass data into remote module with inputs
inputs = {
  vpc_id      = dependency.vpc.outputs.vpc_id
  gateway_id  = dependency.internet_gateway.outputs.gateway_id
  public_a_id = dependency.subnets.outputs.public_a_id
  public_b_id = dependency.subnets.outputs.public_b_id
  env         = local.env_vars.env
}