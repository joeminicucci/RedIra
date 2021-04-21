data "aws_region" "current" {}

data "aws_route53_zone" "phishing_selected" {
  name = join(".",tolist([reverse(split(".", var.domain ))[1],reverse(split(".", var.domain ))[0]]))
}

resource "random_id" "username" {
  keepers = {
    zone_id = data.aws_route53_zone.phishing_selected.zone_id
  }

  byte_length = 6
}

resource "aws_iam_user" "smtp_user" {
  name = "ses-smtp-${random_id.username.hex}"
}

resource "aws_iam_user_policy" "smtp_policy" {
  name = "${aws_iam_user.smtp_user.name}-ses-smtp-policy"
  user = aws_iam_user.smtp_user.name

  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Effect":"Allow",
      "Action":[
        "ses:SendEmail",
        "ses:SendRawEmail"
      ],
      "Resource":"*",
      "Condition":{
        "StringLike":{
          "ses:FromAddress": "*@${var.domain}"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_access_key" "smtp_access_key" {
  user = aws_iam_user.smtp_user.name
}

resource "aws_ses_domain_identity" "identity" {
  domain = var.domain
}

resource "aws_ses_domain_dkim" "dkim" {
  domain = aws_ses_domain_identity.identity.domain
}

resource "aws_ses_domain_mail_from" "mail_from" {
  domain           = aws_ses_domain_identity.identity.domain
  mail_from_domain = "${var.mx_subdomain}.${aws_ses_domain_identity.identity.domain}"
}

resource "aws_route53_record" "ses_txt_record" {
  zone_id = data.aws_route53_zone.phishing_selected.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.identity.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.identity.verification_token]
}

resource "aws_route53_record" "mx_record" {
  zone_id = data.aws_route53_zone.phishing_selected.zone_id
  name    = aws_ses_domain_mail_from.mail_from.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.${data.aws_region.current.name}.amazonses.com"]
}

resource "aws_route53_record" "spf_record" {
  zone_id = data.aws_route53_zone.phishing_selected.zone_id
  name    = aws_ses_domain_mail_from.mail_from.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}

resource "aws_route53_record" "dkim_record" {
  count   = 3
  zone_id = data.aws_route53_zone.phishing_selected.zone_id
  name    = "${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}._domainkey.${aws_ses_domain_identity.identity.domain}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

#for extra convenience - not currently working due to no parent resource - hard to guarantee order. For now, just run the terrform output command to retrieve this data.
//  provisioner "local-exec" {
//    command = <<-EOT
//      echo 'email-smtp.${data.aws_region.current.name}.amazonaws.com' > ./data/credentials/smtp_credentials
//      echo '${aws_iam_access_key.smtp_access_key.id}' >> ./data/credentials/smtp_credentials
//      echo '${aws_iam_access_key.smtp_access_key.ses_smtp_password}' >> ./data/credentials/smtp_credentials
//    EOT
//  }

