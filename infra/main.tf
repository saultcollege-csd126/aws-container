terraform {
    required_version = "v1.14.3"  
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
      }
    }
}

provider "aws" {
    region = var.aws_region
}

import {
  to = aws_cognito_user_pool.xpix
  id = "us-east-1_i2AnPG1Al"
}

import {
  to = aws_cognito_user_pool_client.xpix
  id = "us-east-1_i2AnPG1Al/59fnc58qen1n34du3alap1jf44"
}