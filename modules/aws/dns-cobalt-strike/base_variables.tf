locals {
  data-path = "${path.root}/data"
  playbook-path = "${local.data-path}/playbooks"
  ssh-configs-path = "${local.data-path}/ssh_configs"
  ssh-keys-path = "${local.data-path}/ssh_keys"
  templates-path = "${local.data-path}/templates"
  credentials-path = "${local.data-path}/credentials"
}

variable "vpc_id" {
  type = string
}

variable "amis" {
  type = map(string)
}

variable "instance_type" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "base-internal-security_groups"{
  type = list(string)
}

variable "base-public-security_groups" {
  type = list(string)
}
