# cobalt-strike

Deploys a Cobalt Strike Instance using Ansible

## Example

```hcl
module "cs-ansible"{
  source = "./modules/ansible/cobalt-strike"

  ansible-user = var.cs-dns-c2-user
  ip = module.dns-c2.dns-c2-private-ip
  domain = var.cs-dns-c2-domain
  bind-address = module.dns-rdir.dns-rdr-public-ip
  c2-profile = var.c2-profile
  cs-license = var.cs-license
  teamserver-password = random_password.dns-cs-teamserver-password.result
}

```

## Arguments

| Name                | Required | Value Type   | Description                                     |
|---------------------|----------|--------------|-------------------------------------------------|
| ansible-user        | Yes      | string       | The User to authenticate as                     |
| ip                  | Yes      | string       | The host IP to run the playbook on              |
| cs-license          | Yes      | string       | Cobalt Strike License Key                       |
| bind-address        | Yes      | string       | The address to bind the CS listener to          |
| teamserver-password | Yes      | string       | The password for the CS teamserver              |
| c2-profile          | Yes      | string       | The name of the C2 profile file                 |
| domain              | Yes      | string       | The domain name to deploy on                    |
| arguments           | No       | list(string) | Any additional Ansible arguments to pass in     |
| envs                | no       | list(string) | Environment variables to pass in (-e delimited) |
