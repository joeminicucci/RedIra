locals {
  ansible-config-playbook = "${local.playbook-path}/core_config.yml"
  ansible-rdir-playbook = "${local.playbook-path}/redirector.yml"
}

variable "user" {
  description = "User to authenticate as"
  type = string
}

variable "subnet_id" {
  type = string
}

variable "redirect_to" {
  description = "The back-end C2 server to redirect to"
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
