output "dns-c2-private-ip" {
  value = tostring(aws_instance.dns-c2.private_ip)
}
