locals {
  ansible-config-playbook = "${local.playbook-path}/core_config.yml"
  ansible-cs-playbook = "${local.playbook-path}/cobalt_strike.yml"
}

variable "ansible-user" {
  type = string
}

variable "ip" {
  description = "Host to run playbook on"
  type = string
}

variable "domain" {
  description = "C2 Domain to host from"
  type = string
}

variable "cs-license"{
  type = string
}

variable "bind-address"{
  type = string
}

variable "teamserver-password"{
  type = string
}

variable "c2-profile"{
  type = string
}

variable "arguments" {
  default = []
  type    = list(string)
  description = "Any additional Ansible arguments to pass in."
}

variable "envs" {
  default = []
  type    = list(string)
  description = "Environment variables to pass in. Will be delimited by -e automatically."
}
