output "cs-teamserver-passwords" {
  value = module.cs-dns-c2[*].cs-teamserver-password
}

output "cs-dns-c2-private-ip"{
  value = module.cs-dns-c2[*].cs-dns-c2-private-ip
}

output "cs-dns-rdr-private-ip"{
  value = module.cs-dns-c2[*].cs-dns-rdr-private-ip
}

output "cs-dns-c2-domains"{
  value = var.dns-c2-domain-mappings
}

output "cs-dns-rdr-public-ip"{
  value = module.cs-dns-c2[*].cs-dns-rdr-public-ip
}
