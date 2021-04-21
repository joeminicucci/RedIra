#c2
output "http-cs-teamserver-passwords" {
  value = module.infra-cs-http-c2[*].cs-teamserver-password
}
output "dns-cs-teamserver-passwords" {
  value = module.infra-cs-dns-c2[*].cs-teamserver-password
}


output "http-c2-private-ip"{
  value = module.infra-cs-http-c2[*].cs-http-c2-private-ip
}
output "dns-c2-private-ip"{
  value = module.infra-cs-dns-c2[*].cs-dns-c2-private-ip
}


output "http-rdr-private-ip"{
  value = module.infra-cs-http-c2[*].cs-http-rdr-private-ip
}
output "dns-rdr-private-ip"{
  value = module.infra-cs-dns-c2[*].cs-dns-rdr-private-ip
}


output "http-rdr-public-ip"{
  value = module.infra-cs-http-c2[*].cs-http-rdr-public-ip
}
output "dns-rdr-public-ip"{
  value = module.infra-cs-dns-c2[*].cs-dns-rdr-public-ip
}

output "cs-http-domains" {
  value = var.http-c2-domain-mappings
}
output "cs-dns-domains" {
  value = var.dns-c2-domain-mappings
}

#phishing
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
