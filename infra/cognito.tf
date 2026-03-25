resource "aws_cognito_user_pool_client" "xpix" {
  access_token_validity                         = 60
  allowed_oauth_flows                           = ["code"]
  allowed_oauth_flows_user_pool_client          = true
  allowed_oauth_scopes                          = ["email", "openid", "phone"]
  auth_session_validity                         = 3
  callback_urls                                 = ["http://localhost:5001/", "http://localhost:5001/authorize"]
  default_redirect_uri                          = "http://localhost:5001/"
  enable_propagate_additional_user_context_data = false
  enable_token_revocation                       = true
  explicit_auth_flows                           = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_AUTH", "ALLOW_USER_SRP_AUTH"]
  generate_secret                               = null
  id_token_validity                             = 60
  logout_urls                                   = ["http://localhost:5001/"]
  name                                          = "xpix"
  prevent_user_existence_errors                 = "ENABLED"
  read_attributes                               = []
  refresh_token_validity                        = 5
  region                                        = "us-east-1"
  supported_identity_providers                  = ["COGNITO"]
  user_pool_id                                  =  aws_cognito_user_pool.xpix.id
  write_attributes                              = []
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}

# __generated__ by Terraform from "us-east-1_vs4V1dYLs"
resource "aws_cognito_user_pool" "xpix" {
  alias_attributes           = null
  auto_verified_attributes   = ["email"]
  deletion_protection        = "ACTIVE"
  mfa_configuration          = "OFF"
  name                       = "User pool - 7p3z4j"
  region                     = "us-east-1"
  sms_authentication_message = null
  tags                       = {}
  tags_all                   = {}
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
    configuration_set      = null
    email_sending_account  = "COGNITO_DEFAULT"
    from_email_address     = null
    reply_to_email_address = null
    source_arn             = null
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
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
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



resource "aws_ssm_parameter" "user_pool_id" {

name = "/app/cognito/user_pool_id"
type = "String"
value = aws_cognito_user_pool.xpix.id
}

import{
  to = aws_ssm_parameter.user_pool_id
  id = "/app/cognito/user_pool_id"
}

resource "aws_ssm_parameter" "client_id" {

  name = "/app/cognito/client_id"
  type = "String"
  value = aws_cognito_user_pool_client.xpix.id
}

import{
  to = aws_ssm_parameter.client_id
  id = "/app/cognito/client_id"
}