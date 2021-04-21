# http-rdir

Creates a HTTP Redirector server in AWS. SSH keys for each instance will be outputted to the ssh_keys folder.

## Example

```hcl
module "http-rdir" {
  source = "../http-rdir"

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

| Name               | Description                 |
|--------------------|-----------------------------|
| http-rdr-private-ip | The redirector's private IP |
| http-rdr-public-ip  | The redirector's public IP  |
