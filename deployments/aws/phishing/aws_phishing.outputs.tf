output "gophish-ip" {
  value = module.infra-phishing-gophish[*].gophish-ip
}

output "gophish-credentials-usernames" {
  value = module.infra-phishing-gophish[*].gophish-credentials-username
}

output "gophish-credentials-passwords" {
  value = module.infra-phishing-gophish[*].gophish-credentials-password
}

output "smtp-server" {
    value = module.infra-phishing-gophish[*].smtp-server
}

output "smtp-user" {
    value = module.infra-phishing-gophish[*].smtp-user
}

output "smtp-password" {
    value = module.infra-phishing-gophish[*].smtp-password
}

output "phishing-domains" {
  value = var.phishing-domain-mappings
}