# aws_c2_http

Create a Cobalt Strike HTTP server C2 in AWS

## Arguments

| Name                    | Required | Value Type   | Description                     |
|-------------------------|----------|--------------|---------------------------------|
| http-c2-amount          | No       | number       | The amount of servers to add    |
| http-c2-user            | No       | string       | The User to authenticate as     |
| http-c2-domain-mappings | Yes      | list(string) | The domain names to deploy on   |
| cs-license              | Yes      | string       | Cobalt Strike License Key       |
| http-c2-profile         | Yes      | string       | The name of the C2 profile file |

## Outputs

| Name                   | Description              |
|------------------------|--------------------------|
| cs-teamserver-password | Teamserver Password      |
| cs-http-c2-private-ip  | C2 Private IP            |
| cs-http-rdr-private-ip | Redirector Private IP    |
| cs-http-c2-domains     | The domains to deploy to |
| cs-http-rdr-public-ip  | Redirector Public IP     |
