data "archive_file" "lambda" {
  type        = "zip"
  source_file = "send_email.py"
  output_path = "lambda_function_payload.zip"
}




resource "aws_lambda_function" "send-email" {
  filename      = "lambda_function_payload.zip"
  function_name = "send_email"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "send_email.send_email"
  runtime       = "python3.8"

  environment {
    variables = {
      SENDER_EMAIL = aws_ses_email_identity.sender-mail.email
      RECIPIENT_EMAIL = var.receiver_mail 
    }
  }
}
