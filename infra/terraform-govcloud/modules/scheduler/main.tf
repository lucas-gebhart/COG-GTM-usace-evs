# EventBridge Scheduler (IL5 listed) runs the ingest task every 15 minutes, matching the LPMS refresh cadence.
# This replaces the `ingest --loop` process used in Compose and on Fly with a run-to-completion task.

data "aws_iam_policy_document" "assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["scheduler.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.name}-scheduler"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

data "aws_iam_policy_document" "run_task" {
  statement {
    actions   = ["ecs:RunTask"]
    resources = [var.task_definition_arn, replace(var.task_definition_arn, "/:\\d+$/", ":*")]
    condition {
      test     = "ArnEquals"
      variable = "ecs:cluster"
      values   = [var.cluster_arn]
    }
  }
  statement {
    actions   = ["iam:PassRole"]
    resources = var.task_role_arns
    condition {
      test     = "StringLike"
      variable = "iam:PassedToService"
      values   = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "run_task" {
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.run_task.json
}

resource "aws_scheduler_schedule_group" "this" {
  name = var.name
}

resource "aws_scheduler_schedule" "ingest" {
  name                         = "${var.name}-ingest"
  group_name                   = aws_scheduler_schedule_group.this.name
  schedule_expression          = var.schedule_expression
  schedule_expression_timezone = "UTC"
  state                        = "ENABLED"

  flexible_time_window {
    mode                      = "FLEXIBLE"
    maximum_window_in_minutes = 2
  }

  target {
    arn      = var.cluster_arn
    role_arn = aws_iam_role.this.arn

    ecs_parameters {
      task_definition_arn = var.task_definition_arn
      launch_type         = "FARGATE"
      platform_version    = "LATEST"
      task_count          = 1
      network_configuration {
        subnets          = var.subnet_ids
        security_groups  = var.security_group_ids
        assign_public_ip = false
      }
    }
    retry_policy {
      maximum_retry_attempts       = 2
      maximum_event_age_in_seconds = 600
    }
  }
}
