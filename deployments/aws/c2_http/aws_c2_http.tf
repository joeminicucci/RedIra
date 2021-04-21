module "cs-http-c2" {
  source = "./modules/aws/http-cobalt-strike"
  count = var.http-c2-amount

  #managed
  cs-http-c2-user = var.http-c2-user
  cs-http-c2-domain = var.http-c2-domain-mappings[count.index]
  cs-license = var.cs-license
  c2-profile = var.http-c2-profile

  #base
  vpc_id = var.vpc_id
  amis = var.amis
  instance_type = var.instance_type
  public_subnet_id = var.public_subnet_id
  private_subnet_id = var.private_subnet_id
  base-internal-security_groups = var.base-internal-security_groups
  base-public-security_groups = var.base-public-security_groups
}


