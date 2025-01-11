# AWS Region where resources will be deployed
variable "aws_region" {
  type        = string
  description = "AWS Region to deploy resources"
}

# environment for the deployment
variable "environment" {
  type        = string
  description = "Environment for the deployment"
}

# Tags to be assigned to resources
variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
}

# parameter store
variable "flairgate_apiuser" {
  type = string
}

variable "flairgate_apipassword" {
  type = string
}

variable "jwt_token" {
  type = string
}

# method search ancillary
variable "bookingKey" {
  type = string
}

# method bagge
variable "cityPair" {
  type = string
}

variable "currency" {
  type = string
}

variable "departure" {
  type = string
}

variable "departureDate" {
  type = string
}

variable "passengerCounts" {
  type = string
}

variable "passengerCount" {
  type = string
}