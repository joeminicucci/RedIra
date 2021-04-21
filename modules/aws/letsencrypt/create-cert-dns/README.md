# create-cert-dns

Creates a Let's Encrypt TLS certificate for the specfied domain using the DNS challenge.

# Example

```hcl
module "http-c2-create-certs" {
  source = "../letsencrypt/create-cert-dns"

  #managed
  domain = var.cs-http-c2-domain
  subject_alternative_names = {
    (var.cs-http-c2-domain) = ["*.${var.cs-http-c2-domain}"]
  }

  reg_email = "${var.cs-http-c2-user}@${local.cs-http-c2-tld}"
  dns_provider = "route53"
}
```

## Arguments

| Name                      | Required | Value Type  | Description                                                         |
|---------------------------|----------|-------------|---------------------------------------------------------------------|
| dns_provider              | No       | string      | The DNS provider. Defaults to route53                               |
| domain                    | Yes      | string      | The domain name to deploy on                                        |
| subject_alternative_names | Yes      | map(string) | The SAN entries for certificate                                     |
| reg_email                 | No       | string      | The registration email for the cert. Defaults to nobody@example.com |
| key_type                  | No       | number      | The TLS RSA key bit size. Defaults to 4096                          |

## Outputs

| Name                              | Description                                 |
|-----------------------------------|---------------------------------------------|
| certificate_domain                |                                             |
| certificate_url                   |                                             |
| certificate_pem                   |                                             |
| certificate_private_key_pem       |                                             |
| certificate_issuer_pem            |                                             |
| certificate_file_path             | The output file path of the TLS public key  |
| certificate_private_key_file_path | The output file path of the TLS private key |