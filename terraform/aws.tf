resource "aws_s3_bucket" "primary" {
  bucket        = var.aws_bucket_name
  force_destroy = true

  tags = {
    Name        = "koko-weather-primary"
    Environment = "production"
    Project     = "multi-cloud-weather-tracker"
  }
}

resource "aws_s3_bucket_website_configuration" "primary" {
  bucket = aws_s3_bucket.primary.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "primary" {
  bucket = aws_s3_bucket.primary.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "primary" {
  bucket = aws_s3_bucket.primary.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.primary.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.primary]
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.primary.id
  key          = "index.html"
  source       = "../app/index.html"
  content_type = "text/html"
  etag         = filemd5("../app/index.html")
}