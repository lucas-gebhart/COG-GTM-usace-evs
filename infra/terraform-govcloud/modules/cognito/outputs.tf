output "user_pool_id" { value = aws_cognito_user_pool.this.id }
output "issuer" { value = "https://cognito-idp.${data.aws_region.current.name}.amazonaws.com/${aws_cognito_user_pool.this.id}" }
output "web_client_id" { value = aws_cognito_user_pool_client.web.id }
output "hosted_ui_domain" { value = aws_cognito_user_pool_domain.this.domain }
