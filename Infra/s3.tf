
# Creating s3 bucket and blocking public access
resource "aws_s3_bucket" "bucket" {
  bucket = "efuse-s3bucket-work-sample"
}

# s3 bucket policy allowing public read access to objects within the bucket, list objects wont be allowed, since s3:ListObject is not part of the policy below.
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.bucket
  acl    = "private"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      { Sid       = "PublicReadGetObject"
        Effect    = "Allow",
        Principal = "*",
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion"

        ],
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*",
          "${aws_s3_bucket.bucket.arn}",
        ]
      }
    ]
  })
}
