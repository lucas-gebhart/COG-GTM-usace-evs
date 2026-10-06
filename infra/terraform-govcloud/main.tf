# USACE EVS reference architecture for AWS GovCloud (IL5). Code only: validated in CI, not applied.
# Service choices follow docs/PLAN.md section 3 and docs/research/evs_architecture_report.md section 2.1.

module "network" {
  source = "./modules/network"

  name               = local.name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  enable_nat_gateway = var.enable_nat_gateway
  region             = var.region
}

module "s3" {
  source = "./modules/s3"

  name       = local.name
  account_id = data.aws_caller_identity.current.account_id
}

module "aurora" {
  source = "./modules/aurora-postgresql"

  name               = local.name
  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.private_subnet_ids
  app_security_group = module.ecs.tasks_security_group_id
  engine_version     = var.aurora_engine_version
  serverless         = var.aurora_serverless
  reader_count       = var.aurora_reader_count
}

module "cognito" {
  source = "./modules/cognito"

  name                    = local.name
  callback_urls           = var.web_callback_urls
  icam_oidc_issuer        = var.icam_oidc_issuer
  icam_oidc_client_id     = var.icam_oidc_client_id
  icam_oidc_client_secret = var.icam_oidc_client_secret
}

module "ecs" {
  source = "./modules/ecs"

  name                = local.name
  region              = var.region
  partition           = local.partition
  vpc_id              = module.network.vpc_id
  vpc_cidr            = var.vpc_cidr
  public_subnet_ids   = module.network.public_subnet_ids
  private_subnet_ids  = module.network.private_subnet_ids
  alb_internal        = var.alb_internal
  alb_certificate_arn = var.alb_certificate_arn
  allowed_cidrs       = var.allowed_cidrs
  image_tag           = var.image_tag

  database_secret_arn  = module.aurora.master_user_secret_arn
  database_host        = module.aurora.writer_endpoint
  database_kms_key_arn = module.aurora.kms_key_arn
  oidc_issuer          = module.cognito.issuer
  oidc_audience        = module.cognito.web_client_id
  raw_bucket_arn       = module.s3.raw_bucket_arn
  raw_bucket_name      = module.s3.raw_bucket_name
  tiles_bucket_arn     = module.s3.tiles_bucket_arn
  tiles_bucket_name    = module.s3.tiles_bucket_name
  log_kms_key_arn      = module.observability.log_kms_key_arn
}

module "scheduler" {
  source = "./modules/scheduler"

  name                = local.name
  partition           = local.partition
  schedule_expression = var.ingest_schedule_expression
  cluster_arn         = module.ecs.cluster_arn
  task_definition_arn = module.ecs.ingest_task_definition_arn
  subnet_ids          = module.network.private_subnet_ids
  security_group_ids  = [module.ecs.tasks_security_group_id]
  task_role_arns      = [module.ecs.task_execution_role_arn, module.ecs.ingest_task_role_arn]
}

module "observability" {
  source = "./modules/observability"

  name              = local.name
  region            = var.region
  alb_arn_suffix    = module.ecs.alb_arn_suffix
  aurora_cluster_id = module.aurora.cluster_identifier
  alarm_email       = var.alarm_email
}
