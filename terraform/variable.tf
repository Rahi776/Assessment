variable "aws_region" {
  description = "The AWS region where resources will be provisioned."
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "The name of the AWS Lambda function."
  type        = string
  default     = "HelloWorldFunction"
}

variable "serverless_zip_path" {
  description = "The path to the Serverless Framework deployment ZIP file."
  type        = string
  default     = "../my-lambda-function/.serverless/my-lambda-function.zip"
}
