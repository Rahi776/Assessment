output "lambda_function_arn" {
  description = "The ARN (Amazon Resource Name) of the AWS Lambda function."
  value       = aws_lambda.hello_world_lambda.arn
}

output "lambda_function_invoke_url" {
  description = "The URL to invoke the AWS Lambda function."
  value       = aws_api_gateway_deployment.api.url
}
