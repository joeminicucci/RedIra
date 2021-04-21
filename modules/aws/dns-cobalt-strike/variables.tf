locals {
//  cs-ansible-playbook = "${local.playbook-path}/cobalt_strike.yml"
  cs-dns-c2-tld = join(".",tolist([reverse(split(".", var.cs-dns-c2-domain ))[1],reverse(split(".", var.cs-dns-c2-domain ))[0]]))
}


variable "cs-dns-c2-user" {
  type = string
  description = "User to authenticate as"
}

variable "cs-dns-c2-domain" {
  type = string
}

variable "cs-license"{
  type = string
}

variable "c2-profile" {
  type = string
  description = "The name of the C2 profile file"
}