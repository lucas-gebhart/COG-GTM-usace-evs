variable "name" { type = string }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "app_security_group" {
  description = "Security group of the ECS tasks allowed to reach port 5432."
  type        = string
}
variable "engine_version" { type = string }
variable "serverless" { type = bool }
variable "reader_count" { type = number }
variable "database_name" {
  type    = string
  default = "evs"
}
variable "master_username" {
  type    = string
  default = "evs"
}
