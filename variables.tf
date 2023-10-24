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
        "edgar-care-apk" = {
            "acl" = "private",
            versioning = true
        },
    }
}

variable "lambda_permissions" {
    description = "lambda permissions"

    type = list(any)
    default = [
        {
            name = "graphql",
            "route" = "GET/graphql",
            "state_id" = "AllowGraphQLGet"

        },
        {
            name = "graphql",
            "route" = "POST/graphql",
            "state_id" = "AllowGraphQLPost"

        },
        {
            name = "auth",
            "route" = "POST/auth/p/register",
            "state_id" = "AllowPRegister"

        },
        {
            name = "auth",
            "route" = "POST/auth/p/login",
            "state_id" = "AllowPLogin"

        },
        {
            name = "auth",
            "route" = "POST/auth/d/register",
            "state_id" = "AllowDRegister"

        } ,
        {
            name = "auth",
            "route" = "POST/auth/d/login",
            "state_id" = "AllowDLogin"
        },
        {
            name = "auth",
            "route" = "POST/auth/a/login",
            "state_id" = "AllowALogin"
        },
        {
            name = "auth",
            "route" = "POST/auth/a/register",
            "state_id" = "AllowARegister"

        } ,
        {
            name = "nlp",
            route = "POST/nlp",
            "state_id": "AllowNLP"
        },

        {
            name = "exam",
            "route" = "POST/exam",
            "state_id" = "AllowExam"
        },

        {
            name = "diagnostic",
            "route" = "POST/diagnostic/initiate",
            "state_id" = "AllowInitiate"
        },

        {
            name = "diagnostic",
            "route" = "POST/diagnostic/diagnose",
            "state_id" = "AllowDiagnose"
        },

        {
            name = "onboarding",
            "route" = "POST/onboarding/infos",
            "state_id" = "AllowInfos"
        },

        {
            name = "onboarding",
            "route" = "POST/onboarding/health",
            "state_id" = "AllowHealth"
        },

        {
            name = "pushnotification",
            "route" = "POST/push-notif",
            "state_id" = "AllowPush-notif"
        },
    ]
}