resource "aws_ssm_parameter" "flairgate_apiuser" {
  name        = "/flairgate/apiuser"
  type        = "SecureString"
  value       = var.flairgate_apiuser
  description = "API user for authentication"
}

resource "aws_ssm_parameter" "flairgate_apipassword" {
  name        = "/flairgate/apipassword"
  type        = "SecureString"
  value       = var.flairgate_apipassword
  description = "API password for authentication"
}

resource "aws_ssm_parameter" "jwt_token" {
  name        = "/jwt/secret-key/dev"
  type        = "SecureString"
  value       = var.jwt_token
  description = "JWT token for API authentication"
}
