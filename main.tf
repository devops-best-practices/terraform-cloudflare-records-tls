resource "cloudflare_record" "record" {
  for_each = local.resources

  domain   = var.zone
  type     = "A"
  proxied  = var.proxied

  name     = each.value[0]
  value    = each.value[1]
  
  lifecycle {
    ignore_changes = ["proxied"]
  }
}

resource "random_id" "account_name" {
  byte_length = 8
}

resource "tls_private_key" "account_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  email_address   = "${random_id.account_name.hex}@${var.zone}"
  account_key_pem = tls_private_key.account_key.private_key_pem
}

resource "acme_certificate" "cert" {
  account_key_pem = acme_registration.reg.account_key_pem
  common_name     = var.zone
  subject_alternative_names = local.domains

  dns_challenge {
    provider = "cloudflare"
  }
}
