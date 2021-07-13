# Generate provider configuration for all child directories
generate "provider" {
    path      = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents  = <<EOF
terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = ">=2.19.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {}
}

# Get vault secret to access AWS
provider "vault" {}
data "vault_generic_secret" "service_principle" {
  path = "aws/service_test"
}

# Declaration for AWS
provider "aws" {
  region     = "${local.env_vars.region}" # Local variable from environment_vars.yaml 
  access_key = data.vault_generic_secret.service_principle.data["access_key"]
  secret_key = data.vault_generic_secret.service_principle.data["secret_key"]
}
EOF
}

# Remote backend settings for all child directories
remote_state {
  backend = "s3"
  config = {
    bucket         = "tigonguyen-terraform-state"
    key            = "${local.env_vars.env}/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

# Collect values from env_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file("env_vars.yaml"))
}