########### website_dev REST API Method response###########

# Method Response

# method response accessibility_request
resource "aws_api_gateway_method_response" "accessibility_request_get_response" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  resource_id = aws_api_gateway_resource.accessibility_request.id
  http_method = aws_api_gateway_method.accessibility_request_get.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

}

# method response search ancillary
resource "aws_api_gateway_method_response" "search_ancillary_get_response" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  resource_id = aws_api_gateway_resource.search_ancillary.id
  http_method = aws_api_gateway_method.search_ancillary_get.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

}

# method response baggage
resource "aws_api_gateway_method_response" "baggage_get_response" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  resource_id = aws_api_gateway_resource.baggage.id
  http_method = aws_api_gateway_method.baggage_get.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

}

# method response create_reservation
resource "aws_api_gateway_method_response" "create_reservation_post_response" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  resource_id = aws_api_gateway_resource.create_reservation.id
  http_method = aws_api_gateway_method.create_reservation_post.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

}

# method response flightSelect
resource "aws_api_gateway_method_response" "flight_select_get_response" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  resource_id = aws_api_gateway_resource.flight_select.id
  http_method = aws_api_gateway_method.flight_select_get.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

}


########### JWTtoken REST API Method response###########

# method response for JWTtoken_get
resource "aws_api_gateway_method_response" "JWTtokenGenerator_get_response" {
  rest_api_id = aws_api_gateway_rest_api.jwt_token.id
  resource_id = aws_api_gateway_resource.JWTtokenGenerator.id
  http_method = aws_api_gateway_method.JWTtokenGenerator_get.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

}

# method response JWTtokenGenerator
resource "aws_api_gateway_method_response" "JWTtokenGenerator_post_response" {
  rest_api_id = aws_api_gateway_rest_api.jwt_token.id
  resource_id = aws_api_gateway_resource.JWTtokenGenerator.id
  http_method = aws_api_gateway_method.JWTtokenGenerator_post.http_method
  status_code = 200

  response_models = {
    "application/json" = "Empty"
  }

}