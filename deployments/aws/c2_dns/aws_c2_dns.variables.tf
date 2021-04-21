variable "dns-c2-amount"{
  type = number
  default = 1
}

variable "dns-c2-user" {
  type = string
  default = "admin"
  description = "User to authenticate as"
}

variable "dns-c2-domain-mappings" {
  type = list(string)
}

variable "cs-license"{
  type = string
}

variable "dns-c2-profile" {
  type = string
  description = "The name of the C2 profile file"
}
