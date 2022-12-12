variable "aws_region" {
    description = "AWS region for all resources."

    type    = string
    default = "eu-west-3"
}

variable "aws_account_id" {
    description = "AWS account ID for all resources."

    type = string
    default = "146778342232"
}

variable "base_lambda_arn" {
    description = "ARN of the GraphQL lambda"

    type = string
    default = "arn:aws:lambda:eu-west-3:146778342232:function:"
}
