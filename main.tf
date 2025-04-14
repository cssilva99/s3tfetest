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

data "aws_iam_policy_document" "assume"{
  statement{
    effect = "Allow"
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "terraform"{
  name_prefix = "terraform"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}