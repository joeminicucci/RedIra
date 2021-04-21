module "gophish-config-ansible"{
  source = "../core"

  playbook = local.ansible-config-playbook
  user = var.ansible-user
  ip = var.ip
}

module "gophish-ansible"{
  source = "../core"
  depends_on = [module.gophish-config-ansible]

  playbook = local.ansible-gophish-playbook
  user = var.ansible-user
  arguments = ["--extra-vars 'gophish_user=${var.ansible-user} gophish_tls_private_key_path=../certificates/${var.gophish-domain}_privkey.pem gophish_tls_public_key_path=../certificates/${var.gophish-domain}_cert.pem'"]
  ip = var.ip
}
