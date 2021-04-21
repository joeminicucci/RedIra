# AWS Deployments
## Phishing
See [Phishing Deployment](./phishing/README.md) module. The current deployment deploys a GoPhish server with the following assumptions:
- The server is on a private subnet, with a pre-programmed security group. It is not exposed to the internet, other than port 443. Port 443 is a TLS webserver used for GoPhish landing pages.
- The server will forward SMTP traffic to a publicly facing SES relay.
## C2 - DNS
See the [DNS C2 Deployment](./c2_dns/README.md) module. The current deployment deploys a  server with the following assumptions:
- The Cobalt Strike server is on a private subnet, with a pre-programmed security group. It is not exposed to the internet.
- The deployment will place a redirector in front of the C2, from which front-facing internet traffic is forwarded over DNS to the hidden C2 back-end.
## HTTP - DNS
See the [HTTP C2 Deployment](./c2_http/README.md) module. The current deployment deploys a  server with the following assumptions:
- The Cobalt Strike server is on a private subnet, with a pre-programmed security group. It is not exposed to the internet. It is pre-configured with TLS certificates using LetsEncrypt.
- The deployment will place a redirector in front of the C2, from which front-facing internet traffic is forwarded over http/s to the hidden C2 back-end.
## Complete
See the [Complete AWS Deployment](./complete/README.md) module.
- Includes the Phishing, DNS and HTTP deployments, all-in-one.