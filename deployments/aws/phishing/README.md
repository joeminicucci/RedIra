# aws_phishing

Create a Gophish server with an Amazon SES relay for phishing in AWS.

## Arguments

| Name                     | Required | Value Type   | Description                     |
|--------------------------|----------|--------------|---------------------------------|
| phishing-amount          | No       | number       | The amount of servers to add    |
| phishing-user            | No       | string       | The User to authenticate as     |
| phishing-domain-mappings | Yes      | list(string) | The domain names to deploy on   |

## Outputs

| Name                         | Description                |
|------------------------------|----------------------------|
| gophish-ip                   |                            |
| gophish-credentials-username |                            |
| gophish-credentials-password |                            |
| smtp-server                  | The SES SMTP server domain |
| smtp-user                    | The SES username           |
| smtp-password                | The SES smtp password      |
