resource "aws_s3_bucket" "xpix_s3_bucket" {
  bucket = "xpix-photos-26w-25013977"

  tags = {
    Name        = "xpix-photos"
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "xpix_dynamodb_table" {
  name             = "xpix-photos"
  hash_key         = "photo_id"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"

  attribute {
    name = "photo_id"
    type = "S"
  }
  attribute {
    name = "user_id"
    type = "S"
  }
  attribute {
    name = "uploaded_at"
    type = "S"
  }
  attribute {
    name = "feed_key"
    type = "S"
  }

  global_secondary_index {
    name = "user-photos-index"

    key_schema {
      attribute_name = "user_id"
      key_type       = "HASH"
    }
    key_schema {
      attribute_name = "uploaded_at"
      key_type       = "RANGE"
    }
    projection_type = "ALL"
  }

  global_secondary_index {
    name = "feed-index"

    key_schema {
      attribute_name = "feed_key"
      key_type       = "HASH"
    }
    key_schema {
      attribute_name = "uploaded_at"
      key_type       = "RANGE"
    }
    projection_type = "ALL"
  }

}
resource "aws_ssm_parameter" "ssm_param_s3" {
  name  = "/app/s3/photos_bucket_name"
  type  = "String"
  value = aws_s3_bucket.xpix_s3_bucket.id
}
resource "aws_ssm_parameter" "ssm_param_db" {
  name  = "/app/dynamodb/photos_table_name"
  type  = "String"
  value = aws_dynamodb_table.xpix_dynamodb_table.id 
}