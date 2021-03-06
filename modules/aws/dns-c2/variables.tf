locals{
  ansible-playbook = "${local.playbook-path}/core_config.yml"
}

variable "user" {
  description = "User to authenticate as"
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_groups"{
  type = list(string)
  default=[""]
}

variable "security_groups_inbound_dns"{
  type = list(string)
  default=[""]
}

variable "install" {
  type = list(string)
  default = []
}
