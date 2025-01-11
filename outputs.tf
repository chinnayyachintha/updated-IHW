########### website_dev REST API ###########

output "website_api_id" {
  value = aws_api_gateway_rest_api.website_dev.id
}

output "website_api_gateway_url" {
  description = "The API Gateway URL for the stage"
  value       = "https://${aws_api_gateway_rest_api.website_dev.id}.execute-api.${var.aws_region}.amazonaws.com/${var.environment}"
}

output "website_execution_arn" {
  value = aws_api_gateway_rest_api.website_dev.execution_arn
}

########### JWTtoken REST API ###########

output "JWTtoken_api_id" {
  value = aws_api_gateway_rest_api.jwt_token.id
}

output "JWTtoken_api_gateway_url" {
  description = "The API Gateway URL for the stage"
  value       = "https://${aws_api_gateway_rest_api.jwt_token.id}.execute-api.${var.aws_region}.amazonaws.com/${var.environment}"
}

output "jwt_token_execution_arn" {
  value = aws_api_gateway_rest_api.jwt_token.execution_arn
}

#################### Lambda Function name outputs ####################
output "accessibility_request_function_name" {
  value       = aws_lambda_function.accessibility_request.function_name
  description = "The name of the Accessibility Request Lambda function"
}

output "search_ancillary_function_name" {
  value       = aws_lambda_function.search_ancillary.function_name
  description = "The name of the Search Ancillary Lambda function"
}

output "baggage_function_name" {
  value       = aws_lambda_function.baggage.function_name
  description = "The name of the Baggage Lambda function"
}

output "create_reservation_function_name" {
  value       = aws_lambda_function.create_reservation.function_name
  description = "The name of the Create Reservation Lambda function"
}

output "flight_select_function_name" {
  value       = aws_lambda_function.flight_select.function_name
  description = "The name of the Flight Select Lambda function"
}

output "lambda_authorizer_function_name" {
  value       = aws_lambda_function.LamdaAuthorizer.function_name
  description = "The name of the Lambda Authorizer function"
}

output "jwt_token_function_name" {
  value       = aws_lambda_function.JWTtoken.function_name
  description = "The name of the JWT Token Lambda function"
}