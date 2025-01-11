##################### Website_dev REST API #####################
resource "aws_lambda_function" "accessibility_request" {
  filename         = "./lambda_function_files/accessibilityRequest/lambda_function.zip"
  source_code_hash = filebase64sha256("./lambda_function_files/accessibilityRequest/lambda_function.zip")
  function_name    = "accessibilityRequest-${var.environment}-AD"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.jwt_token_role.arn
  runtime          = "python3.12"
  timeout          = 60
  memory_size      = 512
  ephemeral_storage {
    size = 512
  }

  layers = [
    aws_lambda_layer_version.my_layer2.arn,
  ]

  tags = merge(
    {
      Name = "accessibilityRequest-${var.environment}-AD"
    },
    var.tags
  )
}

resource "aws_lambda_function" "search_ancillary" {
  filename         = "./lambda_function_files/ancillarySearch/lambda_function.zip"
  source_code_hash = filebase64sha256("./lambda_function_files/ancillarySearch/lambda_function.zip")
  function_name    = "ancillarySearch-${var.environment}-AD"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.jwt_token_role.arn
  runtime          = "python3.11"
  timeout          = 80
  memory_size      = 512
  ephemeral_storage {
    size = 512
  }

  layers = [
    aws_lambda_layer_version.my_layer1.arn,
    aws_lambda_layer_version.my_layer2.arn,
  ]

  tags = merge(
    {
      Name = "ancillarySearch-${var.environment}-AD"
    },
    var.tags
  )
}

resource "aws_lambda_function" "baggage" {
  filename         = "./lambda_function_files/baggage/lambda_function.zip"
  source_code_hash = filebase64sha256("./lambda_function_files/baggage/lambda_function.zip")
  function_name    = "baggage-${var.environment}-AD"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.jwt_token_role.arn
  runtime          = "python3.11"
  timeout          = 63
  memory_size      = 512
  ephemeral_storage {
    size = 512
  }

  layers = [
    aws_lambda_layer_version.my_layer1.arn,
    aws_lambda_layer_version.my_layer2.arn,
  ]

  tags = merge(
    {
      Name = "baggage-${var.environment}-AD"
    },
    var.tags
  )
}

resource "aws_lambda_function" "create_reservation" {
  filename         = "./lambda_function_files/createReservation/lambda_function.zip"
  source_code_hash = filebase64sha256("./lambda_function_files/createReservation/lambda_function.zip")
  function_name    = "createReservation-${var.environment}-AD"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.jwt_token_role.arn
  runtime          = "python3.12"
  timeout          = 300
  memory_size      = 512
  ephemeral_storage {
    size = 512
  }

  layers = [
    aws_lambda_layer_version.my_layer1.arn,
    aws_lambda_layer_version.my_layer2.arn,
  ]

  tags = merge(
    {
      Name = "createReservation-${var.environment}-AD"
    },
    var.tags
  )
}

resource "aws_lambda_function" "flight_select" {
  filename         = "./lambda_function_files/flightSelection/lambda_function.zip"
  source_code_hash = filebase64sha256("./lambda_function_files/flightSelection/lambda_function.zip")
  function_name    = "flightSelection-${var.environment}-AD"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.jwt_token_role.arn
  runtime          = "python3.11"
  timeout          = 60
  memory_size      = 512
  ephemeral_storage {
    size = 512
  }

  layers = [
    aws_lambda_layer_version.my_layer1.arn,
    aws_lambda_layer_version.my_layer2.arn,
  ]

  tags = merge(
    {
      Name = "flightSelection-${var.environment}-AD"
    },
    var.tags
  )
}

resource "aws_lambda_function" "lowfare_options" {
  filename         = "./lambda_function_files/lowFareoptions/lambda_function.zip"
  source_code_hash = filebase64sha256("./lambda_function_files/lowFareoptions/lambda_function.zip")
  function_name    = "lowFareoptions-${var.environment}-AD"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.jwt_token_role.arn
  runtime          = "python3.11"
  timeout          = 60
  memory_size      = 512
  ephemeral_storage {
    size = 512
  }

  layers = [
    aws_lambda_layer_version.my_layer1.arn,
    aws_lambda_layer_version.my_layer2.arn,
  ]

  tags = merge(
    {
      Name = "lowFareoptions-${var.environment}-AD"
    },
    var.tags
  )
}

resource "aws_lambda_function" "payment_methods" {
  filename         = "./lambda_function_files/paymentMethods/lambda_function.zip"
  source_code_hash = filebase64sha256("./lambda_function_files/paymentMethods/lambda_function.zip")
  function_name    = "paymentMethods-${var.environment}-AD"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.jwt_token_role.arn
  runtime          = "python3.12"
  timeout          = 60
  memory_size      = 512
  ephemeral_storage {
    size = 512
  }

  layers = [
    aws_lambda_layer_version.my_layer1.arn,
    aws_lambda_layer_version.my_layer2.arn,
  ]

  tags = merge(
    {
      Name = "paymentMethods-${var.environment}-AD"
    },
    var.tags
  )
}

resource "aws_lambda_function" "payment_reservation" {
  filename         = "./lambda_function_files/paymentReservations/lambda_function.zip"
  source_code_hash = filebase64sha256("./lambda_function_files/paymentReservations/lambda_function.zip")
  function_name    = "reservationPaymentTransaction_IHW-${var.environment}-AD"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.jwt_token_role.arn
  runtime          = "python3.12"
  timeout          = 60
  memory_size      = 512
  ephemeral_storage {
    size = 512
  }

  layers = [
    aws_lambda_layer_version.my_layer1.arn,
    aws_lambda_layer_version.my_layer2.arn,
  ]

  tags = merge(
    {
      Name = "reservationPaymentTransaction_IHW-${var.environment}-AD"
    },
    var.tags
  )
}

resource "aws_lambda_function" "seat_selection" {
  filename         = "./lambda_function_files/seatSelection/lambda_function.zip"
  source_code_hash = filebase64sha256("./lambda_function_files/seatSelection/lambda_function.zip")
  function_name    = "seatSelection-${var.environment}-AD"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.jwt_token_role.arn
  runtime          = "python3.11"
  timeout          = 63
  memory_size      = 512
  ephemeral_storage {
    size = 512
  }

  layers = [
    aws_lambda_layer_version.my_layer1.arn,
    aws_lambda_layer_version.my_layer2.arn,
  ]

  tags = merge(
    {
      Name = "seatSelection-${var.environment}-AD"
    },
    var.tags
  )
}

resource "aws_lambda_function" "voucher_code" {
  filename         = "./lambda_function_files/voucherCode/lambda_function.zip"
  source_code_hash = filebase64sha256("./lambda_function_files/voucherCode/lambda_function.zip")
  function_name    = "voucherCode-${var.environment}-AD"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.jwt_token_role.arn
  runtime          = "python3.12"
  timeout          = 60
  memory_size      = 512
  ephemeral_storage {
    size = 512
  }

  layers = [
    aws_lambda_layer_version.my_layer1.arn,
    aws_lambda_layer_version.my_layer2.arn,
  ]

  tags = merge(
    {
      Name = "voucherCode-${var.environment}-AD"
    },
    var.tags
  )
}

resource "aws_lambda_function" "flight_search" {
  filename         = "./lambda_function_files/flightSearch/lambda_function.zip"
  source_code_hash = filebase64sha256("./lambda_function_files/flightSearch/lambda_function.zip")
  function_name    = "flightSearch-${var.environment}-AD"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.jwt_token_role.arn
  runtime          = "python3.11"
  timeout          = 60
  memory_size      = 512
  ephemeral_storage {
    size = 512
  }

  layers = [
    aws_lambda_layer_version.my_layer1.arn,
    aws_lambda_layer_version.my_layer2.arn,
  ]
  
  tags = merge(
    {
      Name = "flightSearch-${var.environment}-AD"
    },
    var.tags
  )
}


resource "aws_lambda_function" "LamdaAuthorizer" {
  filename         = "./lambda_function_files/lambdaAuthorizer/lambda_function.zip"
  source_code_hash = filebase64sha256("./lambda_function_files/lambdaAuthorizer/lambda_function.zip")
  function_name    = "LamdaAuthoriser-${var.environment}-AD"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.jwt_token_role.arn
  runtime          = "python3.11"
  timeout          = 60
  memory_size      = 512
  ephemeral_storage {
    size = 512
  }

  layers = [
    aws_lambda_layer_version.my_layer1.arn,
    aws_lambda_layer_version.my_layer2.arn,
  ]

  tags = merge(
    {
      Name = "LamdaAuthoriser-${var.environment}-AD"
    },
    var.tags
  )
}


##################### JWTtoken REST API #####################
# JWTtoken
resource "aws_lambda_function" "JWTtoken" {
  filename         = "./lambda_function_files/JWTtoken/lambda_function.zip"
  source_code_hash = filebase64sha256("./lambda_function_files/JWTtoken/lambda_function.zip")
  function_name    = "JWTtoken-${var.environment}-AD"
  handler          = "lambda_function.lambda_handler"
  role             = aws_iam_role.jwt_token_role.arn
  runtime          = "python3.12"
  timeout          = 60
  memory_size      = 512
  ephemeral_storage {
    size = 512
  }

  layers = [
    aws_lambda_layer_version.my_layer1.arn,
    aws_lambda_layer_version.my_layer2.arn,
  ]

  tags = merge(
    {
      Name = "JWTtoken-${var.environment}-AD"
    },
    var.tags
  )
}
