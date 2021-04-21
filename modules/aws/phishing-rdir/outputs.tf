output "phishing-rdr-private-ip" {
  value = tostring(aws_instance.phishing-rdir.private_ip)
}

output "phishing-rdr-public-ip" {
  value = tostring(aws_instance.phishing-rdir.public_ip)
}