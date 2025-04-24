
resource "aws_s3_bucket_notification" "tfstate_notification" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.send-email.arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
    filter_prefix       = "terraform.tfstate"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}

