# Create S3 Bucket for Terraform state
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "terraform-state-buk-${var.environment}-adks"

  lifecycle {
    prevent_destroy = true
  }
}

# Enable Versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "terraform_state_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Create Server-Side Encryption Configuration for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_bucket_encryption" {
  bucket = aws_s3_bucket.terraform_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Create DynamoDB Table for state locking
resource "aws_dynamodb_table" "terraform_state_locks" {
  name         = "terraform-state-locks-${var.environment}-adks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# terraform {
#   backend "s3" {
#     bucket         = "terraform-state-buk-dev-adks"
#     key            = "state/statefile.tfstate"
#     region         = "ca-central-1"
#     encrypt        = true
#     dynamodb_table = "terraform-state-locks-dev-adks"
#   }
# }