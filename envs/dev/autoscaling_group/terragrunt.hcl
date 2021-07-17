############ Terragrunt section #############
# Get configuration from root directory
include {
    path = find_in_parent_folders()
}

############ Terraform section ##############
# Use remote module for configuration
terraform {
  source = "../../../modules/aws_autoscaling_group"
}

# Collect values from env_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("env_vars.yaml")))
}

# Define dependencies on other modules
dependency "subnets" {
  config_path = "../subnets"
}
dependency "lb" {
  config_path = "../lb"
}
dependency "launch_configuration" {
  config_path = "../launch_configuration"
}

# Pass data into remote module with inputs
inputs = {
  app_a_id         = dependency.subnets.outputs.app_a_id
  app_b_id         = dependency.subnets.outputs.app_b_id
  tg_arn           = dependency.lb.outputs.tg_arn
  launch_conf_name = dependency.launch_configuration.outputs.launch_conf_name
  env              = local.env_vars.env
}
