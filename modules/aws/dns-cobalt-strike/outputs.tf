output "cs-teamserver-password" {
  value = random_password.dns-cs-teamserver-password.result
}

output "cs-dns-c2-private-ip"{
  value = module.dns-c2.dns-c2-private-ip
}

output "cs-dns-rdr-private-ip"{
  value = module.dns-rdir.dns-rdr-private-ip
}

output "cs-dns-rdr-public-ip"{
  value = module.dns-rdir.dns-rdr-public-ip
}
