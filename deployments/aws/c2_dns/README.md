# aws_c2_dns

Create a Cobalt Strike DNS server C2 in AWS

## Arguments

| Name                   | Required | Value Type   | Description                     |
|------------------------|----------|--------------|---------------------------------|
| dns-c2-amount          | No       | number       | The amount of servers to add    |
| dns-c2-user            | No       | string       | The User to authenticate as     |
| dns-c2-domain-mappings | Yes      | list(string) | The domain names to deploy on   |
| cs-license             | Yes      | string       | Cobalt Strike License Key       |
| dns-c2-profile         | Yes      | string       | The name of the C2 profile file |

## Outputs

| Name                   | Description              |
|------------------------|--------------------------|
| cs-teamserver-password | Teamserver Password      |
| cs-dns-c2-private-ip   | C2 Private IP            |
| cs-dns-rdr-private-ip  | Redirector Private IP    |
| cs-dns-c2-domains      | The domains to deploy to |
| cs-dns-rdr-public-ip   | Redirector Public IP     |
