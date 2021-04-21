locals{
    phishing-tld = join(".",tolist([reverse(split(".", var.phishing-domain ))[1],reverse(split(".", var.phishing-domain ))[0]]))
}

variable "phishing-user" {
  type = string
  description = "User to authenticate as"
}

variable "phishing-domain" {
  type = string
}
