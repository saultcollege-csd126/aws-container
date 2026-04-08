terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
import {
  to = aws_cognito_user_pool.xpix
  id = "us-east-1_kCeVdXi7E"
}

import {
  to = aws_cognito_user_pool_client.xpix
  id = "us-east-1_kCeVdXi7E/46oudbk4nu6lkk81jkb80usdab"
}