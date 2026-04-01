# __generated__ by Terraform
# Cleaned and corrected

resource "aws_cognito_user_pool" "xpix" {
  name                       = "User pool - kks5ms"
  auto_verified_attributes   = ["email"]
  deletion_protection        = "ACTIVE"
  mfa_configuration          = "OFF"
  user_pool_tier             = "ESSENTIALS"
  username_attributes        = ["email"]

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  password_policy {
    minimum_length                   = 8
    password_history_size            = 0
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }

  schema {
    name                     = "email"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = true

    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }

  sign_in_policy {
    allowed_first_auth_factors = ["PASSWORD"]
  }

  username_configuration {
    case_sensitive = false
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }
}

resource "aws_cognito_user_pool_client" "xpix" {
  name                                 = "demarios-web-app"
  user_pool_id                         = aws_cognito_user_pool.xpix.id
  access_token_validity                = 60
  id_token_validity                    = 60
  refresh_token_validity               = 5
  auth_session_validity                = 3
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes                 = ["email", "openid", "phone"]
  callback_urls                        = ["http://localhost:5000/", "http://localhost:5000/authorize"]
  logout_urls                          = ["http://localhost:5000/"]
  enable_token_revocation              = true
  explicit_auth_flows                  = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_AUTH", "ALLOW_USER_SRP_AUTH"]
  prevent_user_existence_errors        = "ENABLED"
  supported_identity_providers         = ["COGNITO"]

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}

# ✅ SSM PARAMETERS (required for assignment)

resource "aws_ssm_parameter" "user_pool_id" {
  name  = "/app/cognito/user_pool_id"
  type  = "String"
  value = aws_cognito_user_pool.xpix.id
}

import {
  to = aws_ssm_parameter.user_pool_id
  id = "/app/cognito/user_pool_id"
}

resource "aws_ssm_parameter" "client_id" {
  name  = "/app/cognito/client_id"
  type  = "String"
  value = aws_cognito_user_pool_client.xpix.id
}

import {
  to = aws_ssm_parameter.client_id
  id = "/app/cognito/client_id"
}