provider "aws" {
  region = "ca-central-1"
}

resource "aws_s3_bucket" "terraform" {
  bucket = "terraform.grimoire"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}
