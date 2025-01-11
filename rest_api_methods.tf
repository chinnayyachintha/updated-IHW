########## website_dev REST API methods ##########

# Create API Gateway methods with parameters and authorization for website_dev API
resource "aws_api_gateway_method" "accessibility_request_get" {
  rest_api_id          = aws_api_gateway_rest_api.website_dev.id
  resource_id          = aws_api_gateway_resource.accessibility_request.id
  http_method          = "GET"
  authorization        = "CUSTOM"
  authorizer_id        = aws_api_gateway_authorizer.custom_authorizer.id
  request_validator_id = aws_api_gateway_request_validator.get_validator.id

  request_parameters = {
    "method.request.header.authorizationToken" = false
  }
}

resource "aws_api_gateway_method" "search_ancillary_get" {
  rest_api_id          = aws_api_gateway_rest_api.website_dev.id
  resource_id          = aws_api_gateway_resource.search_ancillary.id
  http_method          = "GET"
  authorization        = "CUSTOM"
  authorizer_id        = aws_api_gateway_authorizer.custom_authorizer.id
  request_validator_id = aws_api_gateway_request_validator.get_validator.id


  request_parameters = {
    "method.request.querystring.bookingKey"    = false,
    "method.request.header.authorizationToken" = false
  }
}

resource "aws_api_gateway_method" "baggage_get" {
  rest_api_id          = aws_api_gateway_rest_api.website_dev.id
  resource_id          = aws_api_gateway_resource.baggage.id
  http_method          = "GET"
  authorization        = "CUSTOM"
  authorizer_id        = aws_api_gateway_authorizer.custom_authorizer.id
  request_validator_id = aws_api_gateway_request_validator.get_validator.id

  request_parameters = {
    "method.request.querystring.cityPair"        = false,
    "method.request.querystring.currency"        = false,
    "method.request.querystring.departure"       = false,
    "method.request.querystring.passengerCounts" = false,
    "method.request.header.authorizationToken"   = false
  }
}

resource "aws_api_gateway_method" "create_reservation_post" {
  rest_api_id          = aws_api_gateway_rest_api.website_dev.id
  resource_id          = aws_api_gateway_resource.create_reservation.id
  http_method          = "POST"
  authorization        = "CUSTOM"
  authorizer_id        = aws_api_gateway_authorizer.custom_authorizer.id
  request_validator_id = aws_api_gateway_request_validator.post_validator.id

  request_parameters = {
    "method.request.header.authorizationToken" = false
  }
}

resource "aws_api_gateway_method" "flight_select_get" {
  rest_api_id          = aws_api_gateway_rest_api.website_dev.id
  resource_id          = aws_api_gateway_resource.flight_select.id
  http_method          = "POST"
  authorization        = "CUSTOM"
  authorizer_id        = aws_api_gateway_authorizer.custom_authorizer.id
  request_validator_id = aws_api_gateway_request_validator.get_validator.id

  request_parameters = {
    "method.request.querystring.cityPair"       = false,
    "method.request.querystring.departureDate"  = false,
    "method.request.querystring.passengerCount" = false,
    "method.request.header.authorizationToken"  = false
  }
}


########## jwt_token REST API methods ##########

# Create API Gateway methods with parameters and authorization for JWTtoken

resource "aws_api_gateway_method" "JWTtokenGenerator_get" {
  rest_api_id   = aws_api_gateway_rest_api.jwt_token.id
  resource_id   = aws_api_gateway_resource.JWTtokenGenerator.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.querystring.name"  = false,
    "method.request.querystring.sub"   = false,
    "method.request.querystring.admin" = false
  }
}

resource "aws_api_gateway_method" "JWTtokenGenerator_post" {
  rest_api_id   = aws_api_gateway_rest_api.jwt_token.id
  resource_id   = aws_api_gateway_resource.JWTtokenGenerator.id
  http_method   = "POST"
  authorization = "NONE"


  request_parameters = {
    "method.request.querystring.name"  = false,
    "method.request.querystring.sub"   = false,
    "method.request.querystring.admin" = false
  }
}
