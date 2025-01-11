########## website_dev REST API Resources ##########

# Define the API Gateway resources
resource "aws_api_gateway_resource" "accessibility_request" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "accessibilityRequest"
}

resource "aws_api_gateway_resource" "search_ancillary" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "searchAncillary"
}

resource "aws_api_gateway_resource" "baggage" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "baggage"
}

resource "aws_api_gateway_resource" "create_reservation" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "createReservation"
}

resource "aws_api_gateway_resource" "flight_select" {
  rest_api_id = aws_api_gateway_rest_api.website_dev.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "flightSelect"
}

# resource "aws_api_gateway_resource" "lowfare_options" {
#   rest_api_id = aws_api_gateway_rest_api.website_dev.id
#   parent_id   = aws_api_gateway_resource.v1.id
#   path_part   = "lowFareoptions"
# }

# resource "aws_api_gateway_resource" "payment_methods" {
#   rest_api_id = aws_api_gateway_rest_api.website_dev.id
#   parent_id   = aws_api_gateway_resource.v1.id
#   path_part   = "paymentMethods"
# }

# resource "aws_api_gateway_resource" "payment_reservation" {
#   rest_api_id = aws_api_gateway_rest_api.website_dev.id
#   parent_id   = aws_api_gateway_resource.v1.id
#   path_part   = "paymentReservation"
# }

# resource "aws_api_gateway_resource" "seat_selection" {
#   rest_api_id = aws_api_gateway_rest_api.website_dev.id
#   parent_id   = aws_api_gateway_resource.v1.id
#   path_part   = "seatSelection"
# }

# resource "aws_api_gateway_resource" "voucher_code" {
#   rest_api_id = aws_api_gateway_rest_api.website_dev.id
#   parent_id   = aws_api_gateway_resource.v1.id
#   path_part   = "voucherCode"
# }

# resource "aws_api_gateway_resource" "flight_search" {
#   rest_api_id = aws_api_gateway_rest_api.website_dev.id
#   parent_id   = aws_api_gateway_resource.v1.id
#   path_part   = "flightSearch"
# }

############## jwt_token REST API Resources #############

resource "aws_api_gateway_resource" "JWTtokenGenerator" {
  rest_api_id = aws_api_gateway_rest_api.jwt_token.id
  parent_id   = aws_api_gateway_rest_api.jwt_token.root_resource_id
  path_part   = "tokenGenerator"
}