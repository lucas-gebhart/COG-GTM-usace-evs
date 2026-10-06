# ECS Fargate services for web (nginx + React) and api (FastAPI), plus the ingest task definition that
# EventBridge Scheduler runs. ALB + WAFv2 in front; no CloudFront (IL2 East/West only). Service discovery
# (Cloud Map) gives nginx a stable `api.<name>.local` upstream, the same role usace-evs-api.internal plays on Fly.

resource "aws_ecs_cluster" "this" {
  name = var.name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name       = aws_ecs_cluster.this.name
  capacity_providers = ["FARGATE"]
  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 1
  }
}

resource "aws_ecr_repository" "this" {
  for_each             = toset(["evs-web", "evs-api"])
  name                 = "${var.name}/${each.key}"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration { scan_on_push = true }
  encryption_configuration { encryption_type = "KMS" }
}

resource "aws_cloudwatch_log_group" "tasks" {
  for_each          = toset(["web", "api", "ingest"])
  name              = "/evs/${var.name}/${each.key}"
  retention_in_days = 90
  kms_key_id        = var.log_kms_key_arn
}

# ---- IAM -----------------------------------------------------------------------------------------------------

data "aws_iam_policy_document" "task_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "execution" {
  name               = "${var.name}-task-execution"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

resource "aws_iam_role_policy_attachment" "execution" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:${var.partition}:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# The execution role injects the Aurora credentials secret as EVS_DATABASE_URL* at task start.
data "aws_iam_policy_document" "execution_secrets" {
  statement {
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [var.database_secret_arn]
  }
  statement {
    actions   = ["kms:Decrypt"]
    resources = [var.database_kms_key_arn, var.log_kms_key_arn]
  }
}

resource "aws_iam_role_policy" "execution_secrets" {
  role   = aws_iam_role.execution.id
  policy = data.aws_iam_policy_document.execution_secrets.json
}

resource "aws_iam_role" "web" {
  name               = "${var.name}-web-task"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

data "aws_iam_policy_document" "web" {
  statement {
    sid       = "ReadBasemap"
    actions   = ["s3:GetObject"]
    resources = ["${var.tiles_bucket_arn}/*"]
  }
}

resource "aws_iam_role_policy" "web" {
  role   = aws_iam_role.web.id
  policy = data.aws_iam_policy_document.web.json
}

resource "aws_iam_role" "api" {
  name               = "${var.name}-api-task"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

data "aws_iam_policy_document" "api" {
  statement {
    sid       = "ReadRawDrops"
    actions   = ["s3:GetObject", "s3:ListBucket"]
    resources = [var.raw_bucket_arn, "${var.raw_bucket_arn}/*"]
  }
}

resource "aws_iam_role_policy" "api" {
  role   = aws_iam_role.api.id
  policy = data.aws_iam_policy_document.api.json
}

resource "aws_iam_role" "ingest" {
  name               = "${var.name}-ingest-task"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

data "aws_iam_policy_document" "ingest" {
  statement {
    sid       = "WriteRawDrops"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket"]
    resources = [var.raw_bucket_arn, "${var.raw_bucket_arn}/*"]
  }
}

resource "aws_iam_role_policy" "ingest" {
  role   = aws_iam_role.ingest.id
  policy = data.aws_iam_policy_document.ingest.json
}

# ---- Security groups -------------------------------------------------------------------------------------------

resource "aws_security_group" "alb" {
  name        = "${var.name}-alb"
  description = "HTTPS from allowed CIDRs"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }
  ingress {
    description = "HTTP (redirected to HTTPS)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }
  egress {
    description = "To tasks"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }
}

resource "aws_security_group" "tasks" {
  name        = "${var.name}-tasks"
  description = "EVS web, api and ingest tasks"
  vpc_id      = var.vpc_id

  ingress {
    description     = "web from ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
  ingress {
    description     = "api from ALB"
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
  ingress {
    description = "api from web (nginx /api proxy)"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    self        = true
  }
  egress {
    description = "Aurora, VPC endpoints, public feeds via NAT"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ---- ALB + WAF -----------------------------------------------------------------------------------------------------

resource "aws_lb" "this" {
  name                       = substr(var.name, 0, 32)
  internal                   = var.alb_internal
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb.id]
  subnets                    = var.alb_internal ? var.private_subnet_ids : var.public_subnet_ids
  drop_invalid_header_fields = true
  idle_timeout               = 3600 # SSE stream for /api/v1/public/locks/stream/events
}

resource "aws_lb_target_group" "web" {
  name        = substr("${var.name}-web", 0, 32)
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    path    = "/healthz"
    matcher = "200"
  }
}

resource "aws_lb_target_group" "api" {
  name        = substr("${var.name}-api", 0, 32)
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    path    = "/api/v1/health"
    matcher = "200"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  dynamic "default_action" {
    for_each = var.alb_certificate_arn == "" ? [1] : []
    content {
      type             = "forward"
      target_group_arn = aws_lb_target_group.web.arn
    }
  }
  dynamic "default_action" {
    for_each = var.alb_certificate_arn == "" ? [] : [1]
    content {
      type = "redirect"
      redirect {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  }
}

resource "aws_lb_listener" "https" {
  count             = var.alb_certificate_arn == "" ? 0 : 1
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-FIPS-2023-04"
  certificate_arn   = var.alb_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_lb_listener_rule" "api" {
  listener_arn = var.alb_certificate_arn == "" ? aws_lb_listener.http.arn : aws_lb_listener.https[0].arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
  condition {
    path_pattern { values = ["/api/*"] }
  }
}

resource "aws_wafv2_web_acl" "this" {
  name  = var.name
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "common"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 2
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "bad-inputs"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "RateLimitPerIP"
    priority = 3
    action {
      block {}
    }
    statement {
      rate_based_statement {
        limit              = 2000
        aggregate_key_type = "IP"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "rate-limit"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.name
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_web_acl_association" "alb" {
  resource_arn = aws_lb.this.arn
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}

# ---- Service discovery ---------------------------------------------------------------------------------------------

resource "aws_service_discovery_private_dns_namespace" "this" {
  name = "${var.name}.local"
  vpc  = var.vpc_id
}

resource "aws_service_discovery_service" "api" {
  name = "api"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.this.id
    dns_records {
      ttl  = 10
      type = "A"
    }
    routing_policy = "MULTIVALUE"
  }
  health_check_custom_config { failure_threshold = 1 }
}

# ---- Task definitions ---------------------------------------------------------------------------------------------

locals {
  api_image = "${aws_ecr_repository.this["evs-api"].repository_url}:${var.image_tag}"
  web_image = "${aws_ecr_repository.this["evs-web"].repository_url}:${var.image_tag}"

  # Same twelve-factor variables as infra/compose and infra/fly; only the values change.
  api_environment = [
    { name = "EVS_ENV", value = "govcloud" },
    { name = "EVS_FEED_SOURCE", value = "live" },
    { name = "EVS_AUTH_DISABLED", value = "false" },
    { name = "EVS_OIDC_ISSUER", value = var.oidc_issuer },
    { name = "EVS_OIDC_AUDIENCE", value = var.oidc_audience },
    { name = "EVS_S3_BUCKET", value = var.raw_bucket_name },
    { name = "EVS_S3_ENDPOINT", value = "https://s3.${var.region}.amazonaws.com" },
    { name = "EVS_PMTILES_URL", value = "/tiles/usace.pmtiles" },
    { name = "EVS_DATABASE_HOST", value = var.database_host },
  ]
  # RDS-managed secret JSON has `username` and `password`; the entrypoint assembles EVS_DATABASE_URL from them.
  api_secrets = [
    { name = "EVS_DATABASE_USER", valueFrom = "${var.database_secret_arn}:username::" },
    { name = "EVS_DATABASE_PASSWORD", valueFrom = "${var.database_secret_arn}:password::" },
  ]

  log_config = { for k in ["web", "api", "ingest"] : k => {
    logDriver = "awslogs"
    options = {
      awslogs-group         = aws_cloudwatch_log_group.tasks[k].name
      awslogs-region        = var.region
      awslogs-stream-prefix = k
    }
  } }
}

resource "aws_ecs_task_definition" "web" {
  family                   = "${var.name}-web"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.web_cpu
  memory                   = var.web_memory
  execution_role_arn       = aws_iam_role.execution.arn
  task_role_arn            = aws_iam_role.web.arn
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([{
    name         = "web"
    image        = local.web_image
    essential    = true
    portMappings = [{ containerPort = 80, protocol = "tcp" }]
    environment = [
      { name = "API_UPSTREAM", value = "http://api.${var.name}.local:8000" },
      { name = "DNS_RESOLVER", value = cidrhost(var.vpc_cidr, 2) }, # VPC resolver (.2)
    ]
    readonlyRootFilesystem = false
    healthCheck = {
      command     = ["CMD-SHELL", "wget -qO- http://127.0.0.1/healthz >/dev/null || exit 1"]
      interval    = 15
      timeout     = 3
      retries     = 5
      startPeriod = 5
    }
    logConfiguration = local.log_config["web"]
  }])
}

resource "aws_ecs_task_definition" "api" {
  family                   = "${var.name}-api"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.api_cpu
  memory                   = var.api_memory
  execution_role_arn       = aws_iam_role.execution.arn
  task_role_arn            = aws_iam_role.api.arn
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([{
    name         = "api"
    image        = local.api_image
    essential    = true
    portMappings = [{ containerPort = 8000, protocol = "tcp" }]
    command = ["sh", "-c", join(" && ", [
      "export EVS_DATABASE_URL=postgresql+asyncpg://$EVS_DATABASE_USER:$EVS_DATABASE_PASSWORD@$EVS_DATABASE_HOST:5432/evs",
      "export EVS_DATABASE_URL_SYNC=postgresql://$EVS_DATABASE_USER:$EVS_DATABASE_PASSWORD@$EVS_DATABASE_HOST:5432/evs?sslmode=require",
      "evs migrate",
      "uvicorn evs.main:app --host 0.0.0.0 --port 8000",
    ])]
    environment = local.api_environment
    secrets     = local.api_secrets
    healthCheck = {
      command     = ["CMD-SHELL", "python -c \"import urllib.request,sys; sys.exit(0 if urllib.request.urlopen('http://127.0.0.1:8000/api/v1/health', timeout=3).status == 200 else 1)\""]
      interval    = 15
      timeout     = 5
      retries     = 5
      startPeriod = 20
    }
    logConfiguration = local.log_config["api"]
  }])
}

resource "aws_ecs_task_definition" "ingest" {
  family                   = "${var.name}-ingest"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.execution.arn
  task_role_arn            = aws_iam_role.ingest.arn
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([{
    name      = "ingest"
    image     = local.api_image
    essential = true
    command = ["sh", "-c", join(" && ", [
      "export EVS_DATABASE_URL_SYNC=postgresql://$EVS_DATABASE_USER:$EVS_DATABASE_PASSWORD@$EVS_DATABASE_HOST:5432/evs?sslmode=require",
      "evs ingest --once",
    ])]
    environment      = local.api_environment
    secrets          = local.api_secrets
    logConfiguration = local.log_config["ingest"]
  }])
}

# ---- Services ---------------------------------------------------------------------------------------------------

resource "aws_ecs_service" "api" {
  name                   = "api"
  cluster                = aws_ecs_cluster.this.id
  task_definition        = aws_ecs_task_definition.api.arn
  desired_count          = var.api_desired_count
  launch_type            = "FARGATE"
  platform_version       = "LATEST"
  enable_execute_command = false

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.tasks.id]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.api.arn
    container_name   = "api"
    container_port   = 8000
  }
  service_registries {
    registry_arn = aws_service_discovery_service.api.arn
  }
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  depends_on = [aws_lb_listener_rule.api]
}

resource "aws_ecs_service" "web" {
  name             = "web"
  cluster          = aws_ecs_cluster.this.id
  task_definition  = aws_ecs_task_definition.web.arn
  desired_count    = 2
  launch_type      = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.tasks.id]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.web.arn
    container_name   = "web"
    container_port   = 80
  }
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  depends_on = [aws_lb_listener.http, aws_ecs_service.api]
}
