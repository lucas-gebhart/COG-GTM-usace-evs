# Aurora PostgreSQL (IL5 listed on the AWS DoD CC SRG page, verified 2026-10-06). Same migrations as the
# postgis/postgis:17-3.5 container: db/migrations/0001_extensions.sql runs CREATE EXTENSION postgis, pgcrypto,
# pg_trgm. PostGIS needs no parameter-group change on Aurora; the extension is in the supported list for 16/17.
# pg_partman (planned for time-series partitions) does need `pg_partman_bgw` in shared_preload_libraries, below.

resource "aws_kms_key" "this" {
  description             = "${var.name} Aurora storage and Performance Insights"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.name}-aurora"
  target_key_id = aws_kms_key.this.key_id
}

resource "aws_db_subnet_group" "this" {
  name       = var.name
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "this" {
  name        = "${var.name}-aurora"
  description = "PostgreSQL from ECS tasks only"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from EVS tasks"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.app_security_group]
  }
  egress {
    description = "None required"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["127.0.0.1/32"]
  }
}

locals {
  family = "aurora-postgresql${split(".", var.engine_version)[0]}"
}

resource "aws_rds_cluster_parameter_group" "this" {
  name        = "${var.name}-cluster"
  family      = local.family
  description = "EVS: TLS required, pg_stat_statements and pg_partman background worker preloaded"

  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }
  parameter {
    name         = "shared_preload_libraries"
    value        = "pg_stat_statements,pg_partman_bgw"
    apply_method = "pending-reboot"
  }
  parameter {
    name  = "log_min_duration_statement"
    value = "1000"
  }
}

resource "aws_rds_cluster" "this" {
  cluster_identifier              = var.name
  engine                          = "aurora-postgresql"
  engine_version                  = var.engine_version
  engine_mode                     = "provisioned"
  database_name                   = var.database_name
  master_username                 = var.master_username
  manage_master_user_password     = true
  master_user_secret_kms_key_id   = aws_kms_key.this.arn
  db_subnet_group_name            = aws_db_subnet_group.this.name
  vpc_security_group_ids          = [aws_security_group.this.id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.this.name
  storage_encrypted               = true
  kms_key_id                      = aws_kms_key.this.arn
  backup_retention_period         = 14
  preferred_backup_window         = "07:00-08:00"
  copy_tags_to_snapshot           = true
  deletion_protection             = true
  enabled_cloudwatch_logs_exports = ["postgresql"]
  skip_final_snapshot             = false
  final_snapshot_identifier       = "${var.name}-final"

  dynamic "serverlessv2_scaling_configuration" {
    for_each = var.serverless ? [1] : []
    content {
      min_capacity = 0.5
      max_capacity = 8
    }
  }
}

resource "aws_rds_cluster_instance" "this" {
  count                                 = 1 + var.reader_count
  identifier                            = "${var.name}-${count.index == 0 ? "writer" : "reader-${count.index}"}"
  cluster_identifier                    = aws_rds_cluster.this.id
  engine                                = aws_rds_cluster.this.engine
  engine_version                        = aws_rds_cluster.this.engine_version
  instance_class                        = var.serverless ? "db.serverless" : "db.r6g.large"
  db_subnet_group_name                  = aws_db_subnet_group.this.name
  publicly_accessible                   = false
  performance_insights_enabled          = true
  performance_insights_kms_key_id       = aws_kms_key.this.arn
  performance_insights_retention_period = 7
  monitoring_interval                   = 60
  monitoring_role_arn                   = aws_iam_role.monitoring.arn
  auto_minor_version_upgrade            = true
}

data "aws_iam_policy_document" "monitoring_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

data "aws_partition" "current" {}

resource "aws_iam_role" "monitoring" {
  name               = "${var.name}-rds-monitoring"
  assume_role_policy = data.aws_iam_policy_document.monitoring_assume.json
}

resource "aws_iam_role_policy_attachment" "monitoring" {
  role       = aws_iam_role.monitoring.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
