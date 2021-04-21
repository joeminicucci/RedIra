output "gophish-ip" {
  value = module.gophish-server.gophish-ip
}

output "gophish-credentials-username" {
  value = module.gophish-server.gophish-credentials-username
}

output "gophish-credentials-password" {
  value = module.gophish-server.gophish-credentials-password
}

output "smtp-server" {
  value = module.smtp-relay.smtp-server
}

output "smtp-user" {
  value = module.smtp-relay.smtp-username
}

output "smtp-password" {
  value = module.smtp-relay.smtp-password
}
