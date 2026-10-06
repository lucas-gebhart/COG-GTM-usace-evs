output "alb_dns_name" {
  description = "Hostname of the ALB in front of web and api. Put the DoD DNS record (CNAME) on this."
  value       = module.ecs.alb_dns_name
}

output "aurora_writer_endpoint" {
  value = module.aurora.writer_endpoint
}

output "aurora_master_user_secret_arn" {
  description = "Secrets Manager secret holding the Aurora master credentials (rotated by RDS)."
  value       = module.aurora.master_user_secret_arn
}

output "cognito_issuer" {
  description = "OIDC issuer for EVS_OIDC_ISSUER; replaces the Keycloak issuer used locally and on Fly."
  value       = module.cognito.issuer
}

output "cognito_web_client_id" {
  value = module.cognito.web_client_id
}

output "ecr_repositories" {
  value = module.ecs.ecr_repository_urls
}

output "raw_bucket_name" {
  value = module.s3.raw_bucket_name
}

output "tiles_bucket_name" {
  value = module.s3.tiles_bucket_name
}

output "ingest_schedule_arn" {
  value = module.scheduler.schedule_arn
}
