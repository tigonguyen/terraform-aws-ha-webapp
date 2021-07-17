terraform {
  required_providers {
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
  region     = "us-east-2"
  access_key = data.vault_generic_secret.service_principle.data["access_key"]
  secret_key = data.vault_generic_secret.service_principle.data["secret_key"]
}

# Create your bucket to store tfstate files
resource "aws_s3_bucket" "terraform_state" {
  bucket = "tigonguyen-terraform-state"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# For locking requirement
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}