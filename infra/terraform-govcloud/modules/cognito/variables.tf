variable "name" { type = string }
variable "callback_urls" { type = list(string) }
variable "icam_oidc_issuer" { type = string }
variable "icam_oidc_client_id" {
  type      = string
  sensitive = true
}
variable "icam_oidc_client_secret" {
  type      = string
  sensitive = true
}
