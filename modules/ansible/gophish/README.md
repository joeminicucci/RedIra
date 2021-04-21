# gophish

Deploys a GoPhish server using Ansible.

## Example

```hcl
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
```

## Arguments

| Name           | Required | Value Type   | Description                                     |
|----------------|----------|--------------|-------------------------------------------------|
| ansible-user   | Yes      | string       | The User to authenticate as                     |
| ip             | Yes      | string       | The host IP to run the playbook on              |
| gophish-domain | Yes      | string       | The domain to deploy on                         |
| arguments      | No       | list(string) | Any additional Ansible arguments to pass in     |
| envs           | no       | list(string) | Environment variables to pass in (-e delimited) |
