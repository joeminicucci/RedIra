# phishing-gophish

Creates an GoPhish server instance in AWS. SSH keys for each instance will be outputted to the ssh_keys folder.

# Example

```hcl
module "infra-phishing-gophish"{
  source = "./modules/aws/phishing-gophish"

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

| Name            | Required | Value Type | Description                 |
|-----------------|----------|------------|-----------------------------|
| phishing-user   | Yes      | string     | The user to authenticate as |
| phishing-domain | Yes      | string     | The domain to deploy on     |

## Outputs

| Name                         | Description                |
|------------------------------|----------------------------|
| gophish_ip                   |                            |
| gophish-credentials-username |                            |
| gophish-credentials-password |                            |
| smtp-server                  | The SES SMTP server domain |
| smtp-user                    | The SES username           |
| smtp-password                | The SES smtp password      |
