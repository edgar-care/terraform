variable "aws_region" {
    description = "AWS region for all resources."

    type    = string
    default = "eu-west-3"
}

variable "aws_profile" {
    description = "AWS Profile to use"

    type = string
    default = "edgar.care"
}

variable "base_lambda_arn" {
    description = "ARN of the GraphQL lambda"

    type = string
    default = "arn:aws:lambda:eu-west-3:146778342232:function:"
}
