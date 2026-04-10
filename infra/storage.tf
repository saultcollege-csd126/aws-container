
resource "aws_s3_bucket" "asmt" {

    bucket = "xpix-pics-22026811"
    tags = {
        Name = "xpix-photos"

    }

}

resource "aws_dynamodb_table" "asmt" {

 name = "xpix-photos"
 billing_mode = PAY_PER_REQUEST
 hash_key = photo_id
 stream_enabled = true
 stream_view_type = NEW_IMAGE
 
    attribute  {
  name = "photo_id"
  type = "S"
  }

    attribute {
   name = "user_id"
   type = "S"
   }

    attribute{
    name = "uploaded_at"
    type = "S"
    }
    
    attribute{
        name = "feed_key"
        type = "S"
    }
    
    global_secondary_index {
        projection_type = ALL
        name = "user-photos-index"

        key_schema {
          attribute_name = "user_id"
          key_type = "HASH"
        }

        key_schema {
            attribute_name = "uploaded_at"
            key_type = "RANGE" 
        }
    
    }
    
    global_secondary_index {
      projection_type = ALL
      name = "feed-index"

      key_schema {
          attribute_name = "feed_key"
          key_type = "HASH"
        }
        key_schema {
            attribute_name = "uploaded_at"
            key_type = "RANGE"
          
        }
    }

}

    resource "aws_ssm_parameter" "asmt" {
        name = "/apps/s3/xpix-pics-22026811"
        value = bucket
        type = "String"

    }

    resource "aws_ssm_parameter" "asmt" {
        name = "/app/dynamodb/xpix-photos"
        value = aws_dynamodb_table
        type = "String"
    
    }