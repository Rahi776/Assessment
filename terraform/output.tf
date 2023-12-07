output "lambda_function_arn" {
  value = aws_lambda_function.hello_world_lambda.arn
}

output "lambda_function_invoke_url" {
  value = aws_api_gateway_deployment.deployment.invoke_url
}


