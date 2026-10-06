# Amazon Cognito (IL5 listed) replaces Keycloak. The evs-web SPA client uses the same Authorization Code + PKCE
# flow; the API swaps EVS_OIDC_ISSUER and reads roles from the `cognito:groups` claim (see apps/api/evs/auth.py).
# CAC holders arrive through federation to Army ICAM / EAMS-A; that provider is a placeholder until the
# issuer and client registration exist (var.icam_oidc_issuer).

resource "aws_cognito_user_pool" "this" {
  name                     = var.name
  mfa_configuration        = "OFF" # federated CAC users; local users are break-glass admins only
  auto_verified_attributes = ["email"]
  deletion_protection      = "ACTIVE"

  admin_create_user_config {
    allow_admin_create_user_only = true
  }
  password_policy {
    minimum_length                   = 15
    require_lowercase                = true
    require_uppercase                = true
    require_numbers                  = true
    require_symbols                  = true
    temporary_password_validity_days = 1
  }
  user_pool_add_ons {
    advanced_security_mode = "ENFORCED"
  }
  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = true
  }
}

resource "aws_cognito_user_pool_domain" "this" {
  domain       = replace(var.name, "_", "-")
  user_pool_id = aws_cognito_user_pool.this.id
}

# Groups mirror the Keycloak realm roles and the three APEX authorization schemes.
resource "aws_cognito_user_group" "roles" {
  for_each = {
    evs_viewer = "Read dashboards (APEX: Authenticated User scheme)"
    evs_pm     = "Project managers (APEX: Contributor scheme)"
    evs_admin  = "Feed thresholds and admin (APEX: Administrator scheme)"
  }
  name         = each.key
  description  = each.value
  user_pool_id = aws_cognito_user_pool.this.id
}

resource "aws_cognito_identity_provider" "icam" {
  count         = var.icam_oidc_issuer == "" ? 0 : 1
  user_pool_id  = aws_cognito_user_pool.this.id
  provider_name = "ArmyICAM"
  provider_type = "OIDC"

  provider_details = {
    client_id                 = var.icam_oidc_client_id
    client_secret             = var.icam_oidc_client_secret
    oidc_issuer               = var.icam_oidc_issuer
    authorize_scopes          = "openid email profile"
    attributes_request_method = "GET"
  }
  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}

resource "aws_cognito_user_pool_client" "web" {
  name            = "evs-web"
  user_pool_id    = aws_cognito_user_pool.this.id
  generate_secret = false

  allowed_oauth_flows                  = ["code"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes                 = ["openid", "email", "profile"]
  callback_urls                        = var.callback_urls
  logout_urls                          = var.callback_urls
  supported_identity_providers         = concat(["COGNITO"], var.icam_oidc_issuer == "" ? [] : ["ArmyICAM"])
  explicit_auth_flows                  = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]
  prevent_user_existence_errors        = "ENABLED"
  access_token_validity                = 60
  id_token_validity                    = 60
  refresh_token_validity               = 8
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "hours"
  }

  depends_on = [aws_cognito_identity_provider.icam]
}

data "aws_region" "current" {}
