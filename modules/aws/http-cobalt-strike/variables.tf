locals {
  cs-ansible-playbook = "${local.playbook-path}/cobalt_strike.yml"
  cs-http-c2-tld = join(".",tolist([reverse(split(".", var.cs-http-c2-domain ))[1],reverse(split(".", var.cs-http-c2-domain ))[0]]))
}


variable "cs-http-c2-user" {
  type = string
  default = "admin"
  description = "User to authenticate as"
}

variable "cs-http-c2-domain" {
  type = string
}

variable "cs-license"{
  type = string
  #sensitive = true
}

variable "c2-profile" {
  type = string
  description = "The name of the C2 profile file"
}
