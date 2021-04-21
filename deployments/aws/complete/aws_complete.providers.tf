terraform {
  required_version = ">= 0.14.0"
  required_providers {
    acme = {
      source = "vancluever/acme"
      version = "~> 2.0.0"
    }
  }
}

provider "acme" {
  server_url = lookup(var.acme_server_urls, var.acme_server_type)
}

