terraform {
  required_version = ">= 1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

import {
  to = aws_cognito_user_pool.xpix
  id = "us-east-1_vs4V1dYLs"
}

import {
  to = aws_cognito_user_pool_client.xpix
  id = "us-east-1_vs4V1dYLs/3uh3ikb5cv52usji9if3gs7ucd"
}       