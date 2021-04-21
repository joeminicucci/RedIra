output "cs-teamserver-password" {
  value = random_password.http-cs-teamserver-password.result
}

output "cs-http-c2-private-ip"{
  value = module.http-c2.http-c2-private-ip
}

output "cs-http-rdr-private-ip"{
  value = module.http-rdir.http-rdr-private-ip
}

output "cs-http-rdr-public-ip"{
  value = module.http-rdir.http-rdr-public-ip
}
