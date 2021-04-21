variable "domain" {
  type = string
}

variable "type" {
  type = string
}

variable "ttl" {
  type = number
  default = 300
}

variable "record" {
  type = map(string)
}
