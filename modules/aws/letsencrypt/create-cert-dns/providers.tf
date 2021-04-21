terraform {
  required_version = ">= 0.14.0"
  required_providers {
    acme = {
      source = "vancluever/acme"
      version = "~> 2.0.0"
    }
  }
}
