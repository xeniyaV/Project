
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Creating s3 bucket and blocking public access
resource "aws_s3_bucket" "bucket" {
  bucket                  = "efuse-bucket-work-sample"
  }

# s3 bucket policy allowing public read access to objects within the bucket.
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      { Sid       = "PublicReadGetObject"
        Effect    = "Allow",
        Principal = "*",
        Action = [
          "s3:GetObject",
        ],
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*",
          "${aws_s3_bucket.bucket.arn}",
        ]
     }
    ]
  })
}
