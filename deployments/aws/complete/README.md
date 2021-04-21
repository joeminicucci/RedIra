# aws_complete

Create a Cobalt Strike HTTP server C2 in AWS

## Arguments

| Name                     | Required | Value Type   | Description                     |
|--------------------------|----------|--------------|---------------------------------|
| http-c2-amount           | No       | number       | The amount of servers to add    |
| http-c2-user             | No       | string       | The User to authenticate as     |
| http-c2-domain-mappings  | Yes      | list(string) | The domain names to deploy on   |
| cs-license               | Yes      | string       | Cobalt Strike License Key       |
| http-c2-profile          | Yes      | string       | The name of the C2 profile file |
| dns-c2-amount            | No       | number       | The amount of servers to add    |
| dns-c2-user              | No       | string       | The User to authenticate as     |
| dns-c2-domain-mappings   | Yes      | list(string) | The domain names to deploy on   |
| dns-c2-profile           | Yes      | string       | The name of the C2 profile file |
| phishing-amount          | No       | number       | The amount of servers to add    |
| phishing-user            | No       | string       | The User to authenticate as     |
| phishing-domain-mappings | Yes      | list(string) | The domain names to deploy on   |

| Name                          | Description                            |
|-------------------------------|----------------------------------------|
| http-cs-teamserver-password   | Teamserver Password                    |
| dns-cs-teamserver-password    | Teamserver Password                    |
| http-c2-private-ip            | C2 Private IP                          |
| http-rdr-private-ip           | Redirector Private IP                  |
| cs-http-domains               | The domains to deploy to               |
| http-rdr-public-ip            | Redirector Public IP                   |
| dns-c2-private-ip             | C2 Private IP                          |
| dns-rdr-private-ip            | Redirector Private IP                  |
| cs-dns-domains                | The domains to deploy to               |
| dns-rdr-public-ip             | Redirector Public IP                   |
| gophish-ip                    |                                        |
| gophish-credentials-usernames |                                        |
| gophish-credentials-passwords |                                        |
| smtp-server                   | The SES SMTP server domain             |
| smtp-user                     | The SES username                       |
| smtp-password                 | The SES smtp password                  |
| phishing-domains              | The phishing domains to deploy to      |
