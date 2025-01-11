################# website_dev REST API integration response #################

# Itegration response

# integration response accessibility_request
resource "aws_api_gateway_integration_response" "accessibility_request_get_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  resource_id = aws_api_gateway_resource.accessibility_request.id
  http_method = aws_api_gateway_method.accessibility_request_get.http_method
  status_code = 200

  response_templates = {
    "application/json" = ""
  }
}

# integration response search ancillary
resource "aws_api_gateway_integration_response" "search_ancillary_get_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  resource_id = aws_api_gateway_resource.search_ancillary.id
  http_method = aws_api_gateway_method.search_ancillary_get.http_method
  status_code = 200

  response_templates = {
    "application/json" = ""
  }
}

# integration response baggage
resource "aws_api_gateway_integration_response" "baggage_get_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  resource_id = aws_api_gateway_resource.baggage.id
  http_method = aws_api_gateway_method.baggage_get.http_method
  status_code = 200

  response_templates = {
    "application/json" = ""
  }
}

# integration response create_reservation
resource "aws_api_gateway_integration_response" "create_reservation_post_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  resource_id = aws_api_gateway_resource.create_reservation.id
  http_method = aws_api_gateway_method.create_reservation_post.http_method
  status_code = 200

  response_templates = {
    "application/json" = ""
  }
}

# integration response flight_select
resource "aws_api_gateway_integration_response" "flight_select_get_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  resource_id = aws_api_gateway_resource.flight_select.id
  http_method = aws_api_gateway_method.flight_select_get.http_method
  status_code = 200

  response_templates = {
    "application/json" = ""
  }
}

################# JWTtoken REST API integration response #################

# integration response JWTtoken_get
resource "aws_api_gateway_integration_response" "JWTtokenGenerator_get_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.jwt_token.id
  resource_id = aws_api_gateway_resource.JWTtokenGenerator.id
  http_method = aws_api_gateway_method.JWTtokenGenerator_get.http_method
  status_code = 200

  response_templates = {
    "application/json" = ""
  }
}

# integration response JWTtokenGenerator
resource "aws_api_gateway_integration_response" "JWTtokenGenerator_post_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.jwt_token.id
  resource_id = aws_api_gateway_resource.JWTtokenGenerator.id
  http_method = aws_api_gateway_method.JWTtokenGenerator_post.http_method
  status_code = 200

  response_templates = {
    "application/json" = ""
  }
}