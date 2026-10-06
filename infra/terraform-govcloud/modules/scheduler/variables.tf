variable "name" { type = string }
variable "partition" { type = string }
variable "schedule_expression" { type = string }
variable "cluster_arn" { type = string }
variable "task_definition_arn" { type = string }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "task_role_arns" {
  description = "Execution and task roles the scheduler may pass to ECS."
  type        = list(string)
}
