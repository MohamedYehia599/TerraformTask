data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}


resource "aws_iam_policy" "lambda_ses_policy" {
  name        = "lambda-ses-email-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = [
        "ses:SendEmail",
        "ses:SendRawEmail"
      ],
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_ses" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_ses_policy.arn
}
