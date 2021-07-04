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
dependency "subnets" {
  config_path = "../subnets"
}
dependency "internet_gateway" {
  config_path = "../internet_gateway"
}
dependency "nat_gateway" {
  config_path = "../nat_gateway"
}

# Pass data into remote module with inputs
inputs = {
  vpc_id               = dependency.vpc.outputs.vpc_id
  internet_gateway_id  = dependency.internet_gateway.outputs.internet_gateway_id
  nat_gateway_id_a     = dependency.nat_gateway.outputs.nat_gateway_id_a
  nat_gateway_id_b     = dependency.nat_gateway.outputs.nat_gateway_id_b
  public_a_id          = dependency.subnets.outputs.public_a_id
  public_b_id          = dependency.subnets.outputs.public_b_id
  app_a_id             = dependency.subnets.outputs.app_a_id
  app_b_id             = dependency.subnets.outputs.app_b_id
  env                  = local.env_vars.env
}