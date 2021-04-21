output "gophish-ip" {
    value = tostring(aws_instance.phishing-server.private_ip)
}

output "gophish-credentials-username" {
    value = chomp(tostring(data.local_file.gophish-credentials-username.content))
}

output "gophish-credentials-password" {
    value = chomp(tostring(data.local_file.gophish-credentials-password.content))
}
