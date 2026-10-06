variable "name" { type = string }
variable "region" { type = string }
variable "partition" { type = string }
variable "vpc_id" { type = string }
variable "vpc_cidr" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "private_subnet_ids" { type = list(string) }
variable "alb_internal" { type = bool }
variable "alb_certificate_arn" { type = string }
variable "allowed_cidrs" { type = list(string) }
variable "image_tag" { type = string }
variable "database_secret_arn" { type = string }
variable "database_host" { type = string }
variable "database_kms_key_arn" { type = string }
variable "oidc_issuer" { type = string }
variable "oidc_audience" { type = string }
variable "raw_bucket_arn" { type = string }
variable "raw_bucket_name" { type = string }
variable "tiles_bucket_arn" { type = string }
variable "tiles_bucket_name" { type = string }
variable "log_kms_key_arn" { type = string }
variable "web_cpu" {
  type    = number
  default = 256
}
variable "web_memory" {
  type    = number
  default = 512
}
variable "api_cpu" {
  type    = number
  default = 512
}
variable "api_memory" {
  type    = number
  default = 1024
}
variable "api_desired_count" {
  type    = number
  default = 2
}
