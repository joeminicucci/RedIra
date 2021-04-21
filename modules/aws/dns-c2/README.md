# dns-c2

Creates a DNS C2 server in AWS. SSH keys for each instance will be outputted to the ssh_keys folder.

## Example

```hcl
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
```

## Arguments

| Name                        | Required | Value Type   | Description                                            |
|-----------------------------|----------|--------------|--------------------------------------------------------|
| user                        | Yes      | string       | The User to authenticate as                            |
| subnet_id                   | Yes      | string       | Subnet ID to create instance in                        |
| security_groups             | No       | list(string) | Security groups to add                                 |
| security_groups_inbound_dns | No       | list(string) | Security groups to allow inbound port 53UDP(DNS) from. |
| install                     | No       | list(string) | Scripts to install inline. Not recommended.            |

## Outputs

| Name                      | Description
|---------------------------|-----------
|`dns-c2-private-ip`        | IP of created instance.
