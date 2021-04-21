locals {
  ansible-gophish-playbook = "${local.playbook-path}/gophish.yml"
  ansible-playbook = "${local.playbook-path}/core_config.yml"
}

variable "user" {
  description = "User to authenticate as"
}

variable "domain" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_groups"{
  type = list(string)
  default=[""]
}

variable "install" {
  type = list(string)
  default = []
}
