################ website_dev REST API Deployment ################

# Create API Gateway deployment with updated integration dependencies for website_Dev

resource "aws_api_gateway_deployment" "website_dev" {
  depends_on = [
    aws_api_gateway_integration.accessibility_request_get_integration,
    aws_api_gateway_integration.search_ancillary_get_integration,
    aws_api_gateway_integration.baggage_get_integration,
    aws_api_gateway_integration.create_reservation_post_integration,
    aws_api_gateway_integration.flight_select_get_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  stage_name  = var.environment

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "website_dev_stage" {
  rest_api_id   = aws_api_gateway_rest_api.website_dev.id
  stage_name    = var.environment
  deployment_id = aws_api_gateway_deployment.website_dev.id

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_logs.arn
    format = jsonencode({
      requestId      = "$context.requestId",
      ip             = "$context.identity.sourceIp",
      caller         = "$context.identity.caller",
      user           = "$context.identity.user",
      requestTime    = "$context.requestTime",
      httpMethod     = "$context.httpMethod",
      resourcePath   = "$context.resourcePath",
      status         = "$context.status",
      protocol       = "$context.protocol",
      responseLength = "$context.responseLength"
    })
  }
}

################ JWTtoken REST API Deployment ################

# Create API Gateway deployment with updated integration dependencies for JWTtoken
resource "aws_api_gateway_deployment" "jwt_token" {
  depends_on = [
    aws_api_gateway_integration.JWTtokenGenerator_get_integration,
    aws_api_gateway_integration.JWTtokenGenerator_post_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.jwt_token.id
  stage_name  = var.environment

  lifecycle {
    create_before_destroy = true
  }
}

# Create API Gateway stage with logging configuration
resource "aws_api_gateway_stage" "jwt_token_stage" {
  deployment_id = aws_api_gateway_deployment.jwt_token.id
  rest_api_id   = aws_api_gateway_rest_api.jwt_token.id
  stage_name    = "dev"

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway_logs.arn
    format = jsonencode({
      requestId      = "$context.requestId",
      ip             = "$context.identity.sourceIp",
      caller         = "$context.identity.caller",
      user           = "$context.identity.user",
      requestTime    = "$context.requestTime",
      httpMethod     = "$context.httpMethod",
      resourcePath   = "$context.resourcePath",
      status         = "$context.status",
      protocol       = "$context.protocol",
      responseLength = "$context.responseLength"
    })
  }
}
