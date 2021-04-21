# smtp

Configures AWS SES relay to send e-mails via SMTP. Handles SPF and DKIM configuration.

## Initial Setup

Note: Once the AWS name servers have been set in the domain registrar configuration, it can
take up to 72 for Amazon to verify the SES domain. Once the domain is verified, a service
limit increase request must be done to disable the SES sandbox and be able to send e-mails
to unverified recipients, this process is documented in the [AWS SES sandbox documentation](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/request-production-access.html).

## Example

```hcl
module "smtp-relay"{
  source = "../smtp"

  #managed
  domain = var.phishing-domain
  mx_subdomain= "mail-relay"
}
```

## Arguments

| Name                      | Required | Value Type | Description
|---------------------------| -------- | ---------- | -----------
|`domain`                   | Yes      | String     | Sender domain name.
|`mx_subdomain`             | No       | String     | MX record subdomain (default: mx).

## Outputs

| Name                      | Value Type | Description
|---------------------------| ---------- | -----------
|`smtp-server`              | String     | Hostname of the SMTP server to use for sending e-mails.
|`smtp-username`            | String     | User name to connect to the SMTP server.
|`smtp-password`            | String     | Password to connect to the SMTP server.
