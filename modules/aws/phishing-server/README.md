# phishing-server

Creates an instance in AWS to be used as a phishing server. SSH keys for each instance will be outputted to the ssh_keys folder.

## Example

```hcl
module "phishing_server" {
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
```

## Arguments

| Name            | Required | Value Type   | Description                                 |
|-----------------|----------|--------------|---------------------------------------------|
| user            | Yes      | string       | The User to authenticate as                 |
| domain          | Yes      | string       | The domain to deploy to                     |
| subnet_id       | Yes      | string       | Subnet ID to create instance in             |
| security_groups | No       | list(string) | Security groups to add                      |
| install         | No       | list(string) | Scripts to install inline. Not recommended. |

## Outputs

| Name                         | Description |
|------------------------------|-------------|
| gophish-ip                   |             |
| gophish-credentials-username |             |
| gophish-credentials-password |             |