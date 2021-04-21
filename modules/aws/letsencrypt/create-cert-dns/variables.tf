variable "dns_provider" {
  type = string
  default = "route53"
}

variable "domain" {
  type = string
}

variable "subject_alternative_names" {
  type = any
}

variable "reg_email" {
  type = string
  default = "nobody@example.com"
}

variable "key_type" {
  type = number
  default = 4096
}
