# phishing-rdir

Creates a GoPhish Redirector server in AWS. SSH keys for each instance will be outputted to the ssh_keys folder.

## Example

```hcl
module "gophish-server-rdir" {
  source = "../phishing-rdir"

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
```

## Arguments

| Name            | Required | Value Type   | Description                                 |
|-----------------|----------|--------------|---------------------------------------------|
| user            | Yes      | string       | The User to authenticate as                 |
| subnet_id       | Yes      | string       | Subnet ID to create instance in             |
| redirect_to     | Yes      | string       | The back-end C2 server to redirect to       |
| security_groups | No       | list(string) | Security groups to add                      |
| install         | No       | list(string) | Scripts to install inline. Not recommended. |

## Outputs

| Name                    | Description                 |
|-------------------------|-----------------------------|
| phishing-rdr-private-ip | The redirector's private IP |
| phishing-rdr-public-ip  | The redirector's public IP  |