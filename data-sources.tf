# Fetch Current Account Details
data "aws_caller_identity" "current" {}

# Declare aws_region data source to get the current region
data "aws_region" "current" {}