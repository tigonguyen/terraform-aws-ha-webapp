# Generate provider configuration for all child directories
generate "provider" {
    path      = "provider.tf"
    if_exists = "overwrite"
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
}

# Get vault secret to access AWS
provider "vault" {}
data "vault_generic_secret" "service_principle" {
  path = "aws/service_test"
}

# Declaration for AWS
provider "aws" {
    region     = local.env_vars.region
    access_key = data.vault_generic_secret.service_principle.data["access_key"]
    secret_key = data.vault_generic_secret.service_principle.data["secret_key"]
}
EOF
}