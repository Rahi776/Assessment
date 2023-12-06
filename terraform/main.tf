provider "aws" {
  region = var.aws_region
}

resource "aws_lambda_function" "hello_world_lambda" {
  function_name = var.lambda_function_name
  runtime       = "nodejs18.x"
  handler       = "handler.hello"
  filename      = var.serverless_zip_path
  source_code_hash = filebase64(var.serverless_zip_path)

  role = aws_iam_role.lambda_exec.arn

  depends_on = [
    aws_iam_role_policy_attachment.lambda,
  ]
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_execution_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_exec.name
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "LambdaAPI"
  description = "API for invoking Lambda function"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello_world_lambda.arn
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "api" {
  depends_on = [aws_lambda_permission.apigw_lambda]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}

