############ Terragrunt section #############
# Get configuration from root directory
include {
    path = find_in_parent_folders()
}

############ Terraform section ##############
# Use remote module for configuration
terraform {
  source = "../../modules/aws_vpc"
}

# Collect values from env_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file("./env_vars.yaml"))
}

# Pass data into remote module with inputs
inputs = {
    vpc_cidr = local.env_vars.vpc_cidr
}