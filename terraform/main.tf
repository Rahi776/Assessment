provider "aws" {
  region = var.aws_region
}

data "aws_iam_role" "existing_lambda_execution_role" {
  name = "lambda_execution_role"
}

resource "aws_lambda_function" "hello_world_lambda" {
  function_name = "hello-world-lambda"
  runtime       = "nodejs18.x"
  handler       = "handler.hello"
  filename      = "${GITHUB_WORKSPACE}/path/to/your/deployment-package.zip"
  role          = data.aws_iam_role.existing_lambda_execution_role.arn
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "my-api"
  description = "My API"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "hello"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.hello_world_lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [aws_api_gateway_integration.integration]

  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}



