variable "phishing-amount"{
  type = number
  default = 1
}

variable "phishing-user" {
  type = string
  default = "admin"
  description = "User to authenticate as"
}

variable "phishing-domain-mappings" {
  type = list(string)
}
