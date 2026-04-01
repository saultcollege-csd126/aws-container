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
  id = "us-east-1_mLjCYqHOq"
}


import {
  to = aws_cognito_user_pool_client.xpix
  id = "us-east-1_mLjCYqHOq/cf6krf1kd4qu1802o4lrel9ri"
}

output "public_ip" {
  value = aws_instance.xpix_server.public_ip
}