resource "random_password" "http-cs-teamserver-password" {
  length = 15
  special = true
  override_special = "@%)-_+[}:"
}

module "http-c2" {
  source = "../http-c2"

  #managed
  user = var.cs-http-c2-user
  subnet_id = var.private_subnet_id
  instance_type = var.instance_type
  security_groups = var.base-internal-security_groups
  security_groups_inbound_http = var.base-public-security_groups

  #base
  vpc_id = var.vpc_id
  amis = var.amis
}

module "http-rdir" {
  source = "../http-rdir"
  depends_on = [module.http-c2]

  #managed
  user = var.cs-http-c2-user
  subnet_id = var.public_subnet_id
  instance_type = var.instance_type
  security_groups = var.base-public-security_groups
  redirect_to = module.http-c2.http-c2-private-ip

  #base
  vpc_id = var.vpc_id
  amis = var.amis
}

module "http-rdir-A-records" {
  source = "../create-dns-record"
  depends_on = [module.http-rdir]

  #managed
  domain = local.cs-http-c2-tld
  type = "A"
  record = {
    (var.cs-http-c2-domain) = module.http-rdir.http-rdr-public-ip
  }
}

module "http-c2-create-certs" {
  source = "../letsencrypt/create-cert-dns"
  depends_on = [module.http-rdir-A-records]

  #managed
  domain = var.cs-http-c2-domain
  subject_alternative_names = {
    (var.cs-http-c2-domain) = ["*.${var.cs-http-c2-domain}"]
  }

  reg_email = "${var.cs-http-c2-user}@${local.cs-http-c2-tld}"
  dns_provider = "route53"
}

module "http-c2-ansible"{
  source = "../../ansible/cobalt-strike"
  depends_on = [module.http-c2, module.http-c2-create-certs]

  #managed
  ansible-user = var.cs-http-c2-user
  ip = module.http-c2.http-c2-private-ip
  domain = var.cs-http-c2-domain
  bind-address = module.http-rdir.http-rdr-public-ip
  c2-profile = var.c2-profile
  cs-license = var.cs-license
  teamserver-password = random_password.http-cs-teamserver-password.result
}
