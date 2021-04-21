locals {
  ansible-config-playbook = "${local.playbook-path}/core_config.yml"
  ansible-rdir-playbook = "${local.playbook-path}/redirector.yml"
}

variable "user" {
  type = string
  description = "User to authenticate as"
}

variable "subnet_id" {
  type = string
}

variable "redirect_to" {
  type = string
  description = "The back-end C2 server to redirect to"
}

variable "security_groups"{
  type = list(string)
  default=[""]
}

variable "install" {
  type = list(string)
  default = []
}
