############## Website_dev REST API Integration ##############

# Integration for accessibility_request_get method
resource "aws_api_gateway_integration" "accessibility_request_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.website_dev.id
  resource_id             = aws_api_gateway_resource.accessibility_request.id
  http_method             = aws_api_gateway_method.accessibility_request_get.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.accessibility_request.invoke_arn
}


# Integration for search_ancillary_get method
resource "aws_api_gateway_integration" "search_ancillary_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.website_dev.id
  resource_id             = aws_api_gateway_resource.search_ancillary.id
  http_method             = aws_api_gateway_method.search_ancillary_get.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.search_ancillary.invoke_arn

  request_templates = {
    "application/json" = <<EOF
    {
      "bookingKey": "$input.params('bookingKey')"
    }
    EOF
  }
  request_parameters = {
    "integration.request.querystring.bookingKey" = "${var.bookingKey}"
  }
}

# Integration for baggage_get method
resource "aws_api_gateway_integration" "baggage_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.website_dev.id
  resource_id             = aws_api_gateway_resource.baggage.id
  http_method             = aws_api_gateway_method.baggage_get.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.baggage.invoke_arn

  request_templates = {
    "application/json" = <<EOF
   {
     "passengerCounts": "$input.params('passengerCounts')",
     "currency": "$input.params('currency')",
     "departure": "$input.params('departure')",
     "cityPair": "$input.params('cityPair')"
   }
  EOF

  }
  request_parameters = {
    "integration.request.querystring.cityPair"        = "${var.cityPair}",
    "integration.request.querystring.departure"       = "${var.departure}",
    "integration.request.querystring.currency"        = "${var.currency}",
    "integration.request.querystring.passengerCounts" = "${var.passengerCounts}"
  }
}

# Integration for create_reservation_post method
resource "aws_api_gateway_integration" "create_reservation_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.website_dev.id
  resource_id             = aws_api_gateway_resource.create_reservation.id
  http_method             = aws_api_gateway_method.create_reservation_post.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.create_reservation.invoke_arn
}

# Integration for flight_select_get method
resource "aws_api_gateway_integration" "flight_select_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.website_dev.id
  resource_id             = aws_api_gateway_resource.flight_select.id
  http_method             = aws_api_gateway_method.flight_select_get.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.flight_select.invoke_arn

  request_templates = {
    "application/json" = <<EOF
  {
    "departureDate": "$input.params('departureDate')",
    "cityPair": "$input.params('cityPair')",
    "passengerCount": "$input.params('passengerCount')"
  }
  EOF

  }
  request_parameters = {
    "integration.request.querystring.cityPair"       = "${var.cityPair}",
    "integration.request.querystring.departureDate"  = "${var.departureDate}",
    "integration.request.querystring.passengerCount" = "${var.passengerCount}"
  }
}


############## JWTtoken REST API Integration ##############

# Integration for JWTtoken methods

## Integration for JWTtoken_get method
resource "aws_api_gateway_integration" "JWTtokenGenerator_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.jwt_token.id
  resource_id             = aws_api_gateway_resource.JWTtokenGenerator.id
  http_method             = aws_api_gateway_method.JWTtokenGenerator_get.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.JWTtoken.invoke_arn

  request_templates = {
    "application/json" = <<EOF
  {
      "sub": "$input.params('sub')",
      "name": "$input.params('name')",
      "admin": "$input.params('admin')"
  }
   EOF
  }
}

# Integration for JWTtokenGenerator method
resource "aws_api_gateway_integration" "JWTtokenGenerator_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.jwt_token.id
  resource_id             = aws_api_gateway_resource.JWTtokenGenerator.id
  http_method             = aws_api_gateway_method.JWTtokenGenerator_post.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.JWTtoken.invoke_arn
}
