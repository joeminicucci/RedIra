variable "http-c2-amount"{
  type = number
  default = 1
}
variable "dns-c2-amount"{
  type = number
  default = 1
}
variable "phishing-amount"{
  type = number
  default = 1
}


variable "dns-c2-user" {
  type = string
  default = "admin"
  description = "User to authenticate as"
}
variable "http-c2-user" {
  type = string
  default = "admin"
  description = "User to authenticate as"
}
variable "phishing-user" {
  type = string
  default = "admin"
  description = "User to authenticate as"
}


variable "dns-c2-domain-mappings" {
  type = list(string)
}
variable "http-c2-domain-mappings" {
  type = list(string)
}
variable "phishing-domain-mappings" {
  type = list(string)
}

variable "dns-c2-profile" {
  type = string
  description = "The name of the C2 profile file"
}
variable "http-c2-profile" {
  type = string
  description = "The name of the C2 profile file"
}

variable "cs-license"{
  type = string
  #sensitive = true
}
