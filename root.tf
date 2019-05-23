provider "aws" {
  version = "~> 2.11"

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

  # Versioning on this bucket is largely a fuckup-recovery tool. Versions are
  # most useful immediately after they're superceded, for rolling back bad state
  # changes. With that in mind, this lifecycle rule takes steps to minimize the
  # cost of storing versions by throwing versions away thirty days after they're
  # superceded. If we don't do state recovery in that time, we probably aren't
  # going to, and if we do need to, we can also reconstruct the state by hand or
  # using `terraform refresh`.
  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days = 30
    }
  }

  tags = {
    Project = "root.tf"
  }
}

