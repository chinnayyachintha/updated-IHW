######## website_dev API

# Define the API Gateway for Website-Dev
resource "aws_api_gateway_rest_api" "website_dev" {
  name        = "Website-${var.environment}-API"
  description = "Website-${var.environment} API"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

}

# The root resource is the base for the path /v1
resource "aws_api_gateway_resource" "v1" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  parent_id   = aws_api_gateway_rest_api.website_dev.root_resource_id
  path_part   = "v1"
}

######### Jwt_token API

# Define the API Gateway for Token
resource "aws_api_gateway_rest_api" "jwt_token" {
  name        = "JWTToken-${var.environment}-API"
  description = "JWTToken-${var.environment}-API"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

}
