# Lambda Layers version for 
resource "aws_lambda_layer_version" "my_layer1" {
  filename            = "./lambda_layers_files/PyJWT.zip"
  layer_name          = "PyJWT-Layer"
  compatible_runtimes = ["python3.9", "python3.10", "python3.11", "python3.12"]

  source_code_hash = filebase64sha256("./lambda_layers_files/PyJWT.zip")
}

resource "aws_lambda_layer_version" "my_layer2" {
  filename            = "./lambda_layers_files/python_dependencies_layer.zip"
  layer_name          = "python_dependencies-Layer"
  compatible_runtimes = ["python3.9", "python3.10", "python3.11", "python3.12"]

  source_code_hash = filebase64sha256("./lambda_layers_files/python_dependencies_layer.zip") # Ensures the layer is updated when the zip file changes
}


