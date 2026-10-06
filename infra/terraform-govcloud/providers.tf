provider "aws" {
  region = var.region # us-gov-west-1 or us-gov-east-1 only; the aws-us-gov partition is derived, never hard-coded.

  default_tags {
    tags = {
      Project     = "USACE-EVS"
      Environment = var.environment
      ImpactLevel = "IL5"
      ManagedBy   = "terraform"
      Repository  = "lucas-gebhart/COG-GTM-usace-evs"
    }
  }
}

data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  name      = "evs-${var.environment}"
  partition = data.aws_partition.current.partition # aws-us-gov
}
