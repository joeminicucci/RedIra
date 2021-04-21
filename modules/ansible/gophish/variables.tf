locals {
  ansible-config-playbook = "${local.playbook-path}/core_config.yml"
  ansible-gophish-playbook = "${local.playbook-path}/gophish.yml"
}

variable "ansible-user" {
  type = string
}

variable "ip" {
  type = string
  description = "Host to run playbook on"
}

variable "gophish-domain" {
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
