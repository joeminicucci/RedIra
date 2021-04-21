variable "http-c2-amount"{
  type = number
  default = 1
}

variable "http-c2-user" {
  type = string
  default = "admin"
  description = "User to authenticate as"
}

variable "http-c2-domain-mappings" {
  type = list(string)
}

variable "cs-license"{
  type = string
}

variable "http-c2-profile" {
  type = string
  description = "The name of the C2 profile file"
}