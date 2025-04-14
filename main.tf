resource "aws_s3_bucket" "tfstate" {
  bucket_prefix = "terraform-state"

  tags = {
    Owner = "Platform Team"
    Purpose = "Terraform state storage"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "tfstate"{
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}