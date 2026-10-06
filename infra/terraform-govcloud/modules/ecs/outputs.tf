output "cluster_arn" { value = aws_ecs_cluster.this.arn }
output "alb_dns_name" { value = aws_lb.this.dns_name }
output "alb_arn_suffix" { value = aws_lb.this.arn_suffix }
output "tasks_security_group_id" { value = aws_security_group.tasks.id }
output "task_execution_role_arn" { value = aws_iam_role.execution.arn }
output "ingest_task_role_arn" { value = aws_iam_role.ingest.arn }
output "ingest_task_definition_arn" { value = aws_ecs_task_definition.ingest.arn }
output "ecr_repository_urls" { value = { for k, r in aws_ecr_repository.this : k => r.repository_url } }
