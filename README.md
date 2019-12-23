# Cloudflare Records TLS

A Terraform module that will create multiple DNS A records and also create a TLS certificate that is valid for all records.

The module uses Cloudflare to create the DNS records and ACME with Let's Encrypt to generate the TLS certificate.

## Usage

```hcl
provider "cloudflare" {
  version = "~> 1.17"
}

provider "acme" {
  version = "~> 1.4"
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

provider "random" {
  version = "~> 2.2"
}

provider "tls" {
  version = "~> 2.1"
}

module "dns" {
  source  = "gendall/records-tls/cloudflare"
  zone    = "gendall.io"
  records = {
    "graph" = "1.2.3.4"
  }
}
```
