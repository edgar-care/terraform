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

variable "buckets" {
    description = "Buckets to be created"

    type = map(any)
    default = {
        "edgar-care-openapi" = {
            "acl" = "private",
            versioning = true
        },
        "edgar-care-apk" = {
            "acl" = "private",
            versioning = true
        },
    }
}

variable "folder-uploads" {
    description = "Name of the folwer where you recup apk"

    type = string
}