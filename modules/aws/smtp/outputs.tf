output "smtp-server" {
  value = "email-smtp.${data.aws_region.current.name}.amazonaws.com"
}

output "smtp-username" {
  value = aws_iam_access_key.smtp_access_key.id
}

output "smtp-password" {
  value = aws_iam_access_key.smtp_access_key.ses_smtp_password_v4
}
