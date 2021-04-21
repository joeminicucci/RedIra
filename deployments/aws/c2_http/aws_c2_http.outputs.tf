output "cs-teamserver-passwords" {
  value = module.cs-http-c2[*].cs-teamserver-password
}

output "cs-http-c2-private-ip"{
  value = module.cs-http-c2[*].cs-http-c2-private-ip
}

output "cs-http-rdr-private-ip"{
  value = module.cs-http-c2[*].cs-http-rdr-private-ip
}

output "cs-http-c2-domains"{
  value = var.http-c2-domain-mappings
}

output "cs-http-rdr-public-ip"{
  value = module.cs-http-c2[*].cs-http-rdr-public-ip
}
