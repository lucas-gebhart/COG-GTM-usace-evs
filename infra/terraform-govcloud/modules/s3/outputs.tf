output "raw_bucket_name" { value = aws_s3_bucket.this["raw"].bucket }
output "raw_bucket_arn" { value = aws_s3_bucket.this["raw"].arn }
output "tiles_bucket_name" { value = aws_s3_bucket.this["tiles"].bucket }
output "tiles_bucket_arn" { value = aws_s3_bucket.this["tiles"].arn }
output "kms_key_arn" { value = aws_kms_key.s3.arn }
