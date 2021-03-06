# dns-cobalt-strike

Creates a Cobalt Strike DNS C2 server in AWS. SSH keys for each instance will be outputted to the ssh_keys folder.

## Example

```hcl
module "cs-dns-c2" {
  source = "./modules/aws/dns-cobalt-strike"

  #managed
  cs-dns-c2-user = var.dns-c2-user
  cs-dns-c2-domain = var.dns-c2-domain-mappings[count.index]
  cs-license = var.cs-license
  c2-profile = var.dns-c2-profile

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

| Name             | Required | Value Type | Description                     |
|------------------|----------|------------|---------------------------------|
| cs-dns-c2-user   | Yes      | string     | The User to authenticate as     |
| cs-dns-c2-domain | Yes      | string     | The domain name to deploy on    |
| cs-license       | Yes      | string     | Cobalt Strike License Key       |
| c2-profile       | Yes      | string     | The name of the C2 profile file |

## Outputs

| Name                   | Description           |
|------------------------|-----------------------|
| cs-teamserver-password | Teamserver Password   |
| cs-dns-c2-private-ip   | C2 Private IP         |
| cs-dns-rdr-private-ip  | Redirector Private IP |
| cs-dns-rdr-public-ip   | Redirector Public IP  |