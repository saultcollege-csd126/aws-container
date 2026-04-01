terraform {
  required_version = "~> 1.14.6"
  
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
  id = "us-east-1_7b7iBGmoD"
}

import {
  to = aws_cognito_user_pool_client.xpix
  id = "us-east-1_7b7iBGmoD/14ev5gqpioclkr7rbf02kg92ta"
}