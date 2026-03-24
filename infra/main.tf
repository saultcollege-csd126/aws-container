terraform {
  required_version = ">= 1.0"

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
  id = "us-east-1_afks661PG"
}

import {
  to = aws_cognito_user_pool_client.xpix
  id = "us-east-1_afks661PG/5pj95crr3bdbb1nfs82587idf6"
}