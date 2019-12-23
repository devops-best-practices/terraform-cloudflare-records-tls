output "tls_key" {
  value = acme_certificate.cert.private_key_pem
}

output "tls_cert" {
  value = acme_certificate.cert.certificate_pem
}
