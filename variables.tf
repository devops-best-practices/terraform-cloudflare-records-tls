variable "zone" {
  type = string
  description = "The main domain that DNS records will be provided within."
}

variable "records" {
  type = map
  description = "A map of DNS name=addresses pairs, where name is a string and addresses is a tuple of IPs."
}

variable "proxied" {
  type = bool
  default = false
  description = "True if the DNS record gets Cloudflare's origin protection."
}

locals {
  # transforms the records from map(name => [address1, address2]) to map(index => [name, address])
  resources = {
    for index, tuple in chunklist(flatten([
      for name, address in var.records:
      setproduct([name], address)
    ]), 2):
    index => tuple
  }

  # adds the environment and zone to the records names
  domains = [
    for name, addresses in var.records:
    "${name}.${var.zone}"
  ]
}
