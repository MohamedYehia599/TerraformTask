resource "aws_ses_email_identity" "sender-mail" {
  email = var.ses_sender_mail
}