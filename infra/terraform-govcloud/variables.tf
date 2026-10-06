variable "region" {
  description = "AWS GovCloud region. Only the two GovCloud regions carry the DoD CC SRG IL5 provisional authorization."
  type        = string
  default     = "us-gov-west-1"
  validation {
    condition     = contains(["us-gov-west-1", "us-gov-east-1"], var.region)
    error_message = "EVS IL5 reference architecture deploys to us-gov-west-1 or us-gov-east-1 only."
  }
}

variable "environment" {
  description = "Deployment name used in resource names and tags (dev, test, prod)."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.60.0.0/16"
}

variable "availability_zones" {
  description = "Two AZs for the ALB, ECS tasks and Aurora. us-gov-west-1 has three (a, b, c)."
  type        = list(string)
  default     = ["us-gov-west-1a", "us-gov-west-1b"]
}

variable "enable_nat_gateway" {
  description = "Egress for the ingest task to reach public USACE/NOAA/USGS feeds. In an enclave with a mandated egress proxy set this to false and route through the proxy instead."
  type        = bool
  default     = true
}

variable "alb_internal" {
  description = "false: internet-facing ALB (NIPR users). true: internal ALB reached over Direct Connect / VPN."
  type        = bool
  default     = false
}

variable "alb_certificate_arn" {
  description = "ACM certificate ARN for the HTTPS listener (DoD PKI issued or ACM Private CA). Empty keeps the listener on HTTP for a code-only validation."
  type        = string
  default     = ""
}

variable "allowed_cidrs" {
  description = "CIDR blocks allowed to reach the ALB (NIPR ranges for production)."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "image_tag" {
  description = "Container image tag for web, api and ingest (the same images Compose and Fly run)."
  type        = string
  default     = "latest"
}

variable "aurora_engine_version" {
  description = "Aurora PostgreSQL engine version. PostGIS 3.4/3.5 ships with 16 and 17 compatible releases."
  type        = string
  default     = "17.4"
}

variable "aurora_serverless" {
  description = "true: Aurora Serverless v2 (0.5 to 8 ACU). false: provisioned db.r6g.large writer (+ reader when aurora_reader_count > 0)."
  type        = bool
  default     = true
}

variable "aurora_reader_count" {
  type    = number
  default = 0
}

variable "ingest_schedule_expression" {
  description = "EventBridge Scheduler expression for the ingest task. LPMS refreshes every 15 minutes."
  type        = string
  default     = "rate(15 minutes)"
}

variable "icam_oidc_issuer" {
  description = "Army ICAM / EAMS-A OIDC issuer URL for Cognito federation. Empty leaves the placeholder provider unconfigured."
  type        = string
  default     = ""
}

variable "icam_oidc_client_id" {
  type      = string
  default   = ""
  sensitive = true
}

variable "icam_oidc_client_secret" {
  type      = string
  default   = ""
  sensitive = true
}

variable "web_callback_urls" {
  description = "OIDC redirect URIs for the evs-web SPA client."
  type        = list(string)
  default     = ["https://evs.example.mil/callback"]
}

variable "alarm_email" {
  description = "Email for CloudWatch alarm notifications (SNS). Empty skips the subscription."
  type        = string
  default     = ""
}
