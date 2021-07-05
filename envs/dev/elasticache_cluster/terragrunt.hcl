############ Terragrunt section #############
# Get configuration from root directory
include {
    path = find_in_parent_folders()
}

############ Terraform section ##############
# Use remote module for configuration
terraform {
  source = "../../../modules/aws_elasticache_cluster"
}

# Collect values from env_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

# Define dependencies on other modules
dependency "security_groups" {
  config_path = "../security_groups"
}
dependency "subnet_groups" {
  config_path = "../subnet_groups"
}

# Pass data into remote module with inputs
inputs = {
  cache_subnet_group_name = dependency.subnet_groups.outputs.cache_subnet_group_name
  cache_sg_id             = dependency.security_groups.outputs.cache_sg_id
  env                  = local.env_vars.env
  region               = local.env_vars.region
}
