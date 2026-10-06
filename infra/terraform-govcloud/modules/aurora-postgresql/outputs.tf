output "cluster_identifier" { value = aws_rds_cluster.this.cluster_identifier }
output "writer_endpoint" { value = aws_rds_cluster.this.endpoint }
output "reader_endpoint" { value = aws_rds_cluster.this.reader_endpoint }
output "master_user_secret_arn" { value = aws_rds_cluster.this.master_user_secret[0].secret_arn }
output "kms_key_arn" { value = aws_kms_key.this.arn }
output "security_group_id" { value = aws_security_group.this.id }
