# AWS Region where resources will be deployed
aws_region = "ca-central-1"

# environment for the deployment
environment = "dev"

# specify tags to be assigned to resources
tags = {
  Environment = "dev"
  Project     = "IHW"
}

# search anicillary
bookingKey = "method.request.querystring.bookingKey"

# baggage
cityPair        = "method.request.querystring.cityPair"
currency        = "method.request.querystring.currency"
departure       = "method.request.querystring.departure"
passengerCounts = "method.request.querystring.passengerCounts"


# flight select
departureDate  = "method.request.querystring.departureDate"
passengerCount = "method.request.querystring.passengerCount"

# parameter store values

flairgate_apiuser = "APIGATE"
flairgate_apipassword = "Flair123$"
jwt_token = "e02dc24260a20e5f3864debf5d768a75e5bb94a3fe43f3490df1776fb8cf9be2"