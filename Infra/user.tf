
# Creating  IAM user
resource "aws_iam_user" "s3_user" {
  name = "efuse-s3-user"
}


# Creating Policy
resource "aws_iam_policy" "user_s3policy" {
  name = "efuse-s3-user-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:ListBucket"
        ],
        Effect = "Allow",
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*",
          "${aws_s3_bucket.bucket.arn}"

        ]
      }
    ]
  })
}

# Attaching above policy to the IAM user
resource "aws_iam_user_policy_attachment" "user_s3policy_attachment" {
  user       = aws_iam_user.s3_user.name
  policy_arn = aws_iam_policy.user_s3policy.arn
}
