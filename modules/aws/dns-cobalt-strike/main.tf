resource "random_password" "dns-cs-teamserver-password" {
  length = 15
  special = true
  override_special = "@%)-_+[}:"
}

module "dns-c2" {
  source = "../dns-c2"

  #managed
  user = var.cs-dns-c2-user
  subnet_id = var.private_subnet_id
  security_groups = var.base-internal-security_groups
  security_groups_inbound_dns = var .base-public-security_groups

  #base
  vpc_id = var.vpc_id
  instance_type = var.instance_type
  amis = var.amis
}

module "dns-rdir" {
  source = "../dns-rdir"
  depends_on = [module.dns-c2]

  #managed
  user = var.cs-dns-c2-user
  subnet_id = var.public_subnet_id
  security_groups = var.base-public-security_groups
  redirect_to = module.dns-c2.dns-c2-private-ip

  #base
  vpc_id = var.vpc_id
  instance_type = var.instance_type
  amis = var.amis
}

module "dns-rdir-naked-A-record" {
  source = "../create-dns-record"
  depends_on = [module.dns-rdir]

  domain = local.cs-dns-c2-tld
  type = "A"
  record = {
    (var.cs-dns-c2-domain) = module.dns-rdir.dns-rdr-public-ip
  }
}

module "dns-rdir-nameserver-A-record" {
  source = "../create-dns-record"
  depends_on = [module.dns-rdir]

  domain = local.cs-dns-c2-tld
  type = "A"
  record = {
    "ns1.${var.cs-dns-c2-domain}" = module.dns-rdir.dns-rdr-public-ip
  }
}

module "dns-rdir-NS-record" {
  source = "../create-dns-record"
  depends_on = [module.dns-rdir]

  domain = local.cs-dns-c2-tld
  type = "NS"
  record = {
    "dns.${var.cs-dns-c2-domain}" = "ns1.${var.cs-dns-c2-domain}"
  }
}

module "dns-c2-create-certs" {
  source = "../letsencrypt/create-cert-dns"
  depends_on = [module.dns-rdir-naked-A-record]

  #managed
  domain = var.cs-dns-c2-domain
  subject_alternative_names = {
    (var.cs-dns-c2-domain) = ["*.${var.cs-dns-c2-domain}"]
  }

  reg_email = "${var.cs-dns-c2-user}@${local.cs-dns-c2-tld}"
  dns_provider = "route53"
}

module "dns-c2-ansible"{
  source = "../../ansible/cobalt-strike"
  depends_on = [module.dns-c2, module.dns-c2-create-certs]

  #managed
  ansible-user = var.cs-dns-c2-user
  ip = module.dns-c2.dns-c2-private-ip
  domain = var.cs-dns-c2-domain
  bind-address = module.dns-rdir.dns-rdr-public-ip
  c2-profile = var.c2-profile
  cs-license = var.cs-license
  teamserver-password = random_password.dns-cs-teamserver-password.result
}
