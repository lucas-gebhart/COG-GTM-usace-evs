output "log_kms_key_arn" { value = aws_kms_key.logs.arn }
output "alarm_topic_arn" { value = aws_sns_topic.alarms.arn }
