# S3 Bucket setup
resource "aws_s3_bucket" "static_website" {
  bucket = "${var.name_prefix}-${var.bucket_name}${var.name_suffix}"

  tags = merge(local.tags,{Name = "${var.name_prefix}-${var.bucket_name}${var.name_suffix}"})    
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse_configuration" {
  bucket = aws_s3_bucket.static_website.id

  rule {
      apply_server_side_encryption_by_default {
        sse_algorithm       = "AES256"
      }
      bucket_key_enabled  = true
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.static_website.id

  block_public_policy     = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.static_website.id
  policy = data.template_file.bucket_policy.rendered
}


resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.static_website.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }
}


data "template_file" "bucket_policy" {
  template = templatefile("${path.module}/policies/bucket_public_policy.json", { bucket_arn = aws_s3_bucket.static_website.arn } )
}