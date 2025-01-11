resource "aws_cloudwatch_log_group" "api_gateway_logs" {
  name              = "/aws/api-gateway/example"
  retention_in_days = 14
}

resource "aws_api_gateway_account" "dev_account" {
  cloudwatch_role_arn = aws_iam_role.cloudwatch.arn
}