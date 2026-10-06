terraform {
  required_version = ">= 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }
  # Remote state is intentionally not configured. When this is applied inside a USACE account, point this at an
  # S3 bucket + DynamoDB lock table in us-gov-west-1 (both IL5 listed) and run `terraform init -migrate-state`.
  # CI validates with `terraform init -backend=false`.
}
