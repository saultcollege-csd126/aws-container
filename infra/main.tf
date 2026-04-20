terraform {
    required_version = ">=1.14.0"
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
      }
    }
}

provider "aws" {
    region = var.aws_region //accessing region variable from the other file.
}

import {
  to = aws_cognito_user_pool.xpix
  id = "us-east-1_R2s5NUHbl"
}

import {
  to = aws_cognito_user_pool_client.xpix
  id = "us-east-1_R2s5NUHbl/1cfqr5aq2sa5sfclsn54sccpj"
}

