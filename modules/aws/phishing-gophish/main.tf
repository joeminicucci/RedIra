module "phishing-create-certs" {
  source = "../letsencrypt/create-cert-dns"

  #managed
  domain = var.phishing-domain
  subject_alternative_names = {
    (var.phishing-domain) = ["*.${var.phishing-domain}"]
  }
  reg_email = "${var.phishing-user}@${local.phishing-tld}"
  dns_provider = "route53"
}

module "gophish-server" {
  source = "../phishing-server"
  depends_on = [module.phishing-create-certs]

  #managed
  user = var.phishing-user
  domain = var.phishing-domain
  subnet_id = var.private_subnet_id
  security_groups = var.base-internal-security_groups

  #base
  vpc_id = var.vpc_id
  instance_type = var.instance_type
  amis = var.amis
}

module "gophish-server-rdir" {
  source = "../phishing-rdir"
  depends_on = [module.gophish-server]

  #managed
  user = var.phishing-user
  subnet_id = var.public_subnet_id
  redirect_to = module.gophish-server.gophish-ip
  security_groups = var.base-public-security_groups

  #base
  vpc_id = var.vpc_id
  instance_type = var.instance_type
  amis = var.amis
}

module "phishing-rdir-A-records" {
  source = "../create-dns-record"
  depends_on = [module.gophish-server-rdir]

  #managed
  domain = local.phishing-tld
  type = "A"

  record = {
    (var.phishing-domain) = module.gophish-server-rdir.phishing-rdr-public-ip
  }
}

module "smtp-relay"{
  source = "../smtp"
  depends_on = [module.gophish-server, module.gophish-server-rdir]

  #managed
  domain = var.phishing-domain
  mx_subdomain= "mail-relay"
}