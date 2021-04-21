output "dns-rdr-private-ip" {
  value = tostring(aws_instance.dns-rdir.private_ip)
}

output "dns-rdr-public-ip" {
  value = tostring(aws_instance.dns-rdir.public_ip)
}
