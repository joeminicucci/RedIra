module "infra-phishing-gophish"{
  source = "./modules/aws/phishing-gophish"
  count = var.phishing-amount

  #managed
  phishing-user = var.phishing-user
  phishing-domain = var.phishing-domain-mappings[count.index]

  #base
  vpc_id = var.vpc_id
  amis = var.amis
  instance_type = var.instance_type
  public_subnet_id = var.public_subnet_id
  private_subnet_id = var.private_subnet_id
  base-internal-security_groups = var.base-internal-security_groups
  base-public-security_groups = var.base-public-security_groups

}