resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits = var.key_type
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.reg_email
}

data "aws_region" "current" {}

data "aws_route53_zone" "selected" {
  name = join(".",tolist([reverse(split(".",var.domain))[1],reverse(split(".",var.domain))[0]]))
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.reg.account_key_pem
  common_name               = var.domain
  subject_alternative_names = var.subject_alternative_names[var.domain]

  dns_challenge {
    provider = var.dns_provider
    config ={ AWS_HOSTED_ZONE_ID = data.aws_route53_zone.selected.zone_id }
  }

  provisioner "local-exec" {
    command = "echo \"${self.private_key_pem}\" > ./data/certificates/${self.common_name}_privkey.pem && echo \"${self.certificate_pem}\" > ./data/certificates/${self.common_name}_cert.pem"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm ./data/certificates/${self.common_name}*"
  }
}