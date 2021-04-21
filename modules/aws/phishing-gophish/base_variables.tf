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
