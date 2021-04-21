module "cs-config-ansible"{
  source = "../core"

  #managed
  user = var.ansible-user
  playbook = local.ansible-config-playbook
  ip = var.ip
}

module "cs-ansible"{
  source = "../core"
  depends_on = [module.cs-config-ansible]

  user = var.ansible-user
  playbook = local.ansible-cs-playbook
  arguments = concat(["--extra-vars 'license_key=${var.cs-license} bind_address=${var.bind-address} teamserver_password=${var.teamserver-password} c2_profile=${var.c2-profile} domain=${var.domain}'"], var.arguments)
  ip = var.ip
  envs = var.envs
}