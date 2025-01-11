# validators

# Create API Gateway request validator
resource "aws_api_gateway_request_validator" "get_validator" {
  name                        = "validate query string parameters and headers"
  rest_api_id                 = aws_api_gateway_rest_api.website_dev.id
  validate_request_body       = true
  validate_request_parameters = true
}

resource "aws_api_gateway_request_validator" "post_validator" {
  name                        = "validate body"
  rest_api_id                 = aws_api_gateway_rest_api.website_dev.id
  validate_request_body       = true
  validate_request_parameters = false
}



# Lambda Authorizer for the API Gateway
resource "aws_api_gateway_authorizer" "custom_authorizer" {
  name                             = "CustomLambdaAuthorizer-${var.environment}-AD"
  rest_api_id                      = aws_api_gateway_rest_api.website_dev.id
  authorizer_uri                   = aws_lambda_function.LamdaAuthorizer.invoke_arn
  identity_source                  = "method.request.header.authorizationToken"
  type                             = "TOKEN"
  authorizer_result_ttl_in_seconds = 0

  depends_on = [
    aws_lambda_function.LamdaAuthorizer,
  ]
}