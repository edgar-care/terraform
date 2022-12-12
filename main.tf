terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">= 4.9.0"
        }
        random = {
            source  = "hashicorp/random"
            version = "~> 3.1.0"
        }
        archive = {
            source  = "hashicorp/archive"
            version = "~> 2.2.0"
        }
    }

    required_version = "~> 1.0"
}

provider "aws" {
    region = var.aws_region
}


module "log_group" {
    source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
    version = "~> 3.0"

    name              = "gateway"
    retention_in_days = 120
}


module "api_gateway" {
    source = "terraform-aws-modules/apigateway-v2/aws"

    name          = "edgar.care"
    description   = "My awesome HTTP API Gateway"
    protocol_type = "HTTP"

    cors_configuration = {
        allow_headers = ["*"]
        allow_methods = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
        allow_origins = ["*"]
    }

    create_api_domain_name = false # to control creation of API Gateway Domain Name

    # Access logs
    default_stage_access_log_destination_arn = module.log_group.cloudwatch_log_group_arn
    default_stage_access_log_format = jsonencode({
        requestId               = "$context.requestId"
        sourceIp                = "$context.identity.sourceIp"
        requestTime             = "$context.requestTime"
        protocol                = "$context.protocol"
        httpMethod              = "$context.httpMethod"
        resourcePath            = "$context.resourcePath"
        routeKey                = "$context.routeKey"
        status                  = "$context.status"
        responseLength          = "$context.responseLength"
        integrationErrorMessage = "$context.integrationErrorMessage"
        }
    )

    # Routes and integrations
    integrations = {
        "GET /graphql" = {
            lambda_arn             = format("%s%s", var.base_lambda_arn, "graphql")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
            // authorizer_key = "cognito"
        }

        "POST /graphql" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "graphql")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /auth/d/login" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
            // authorizer_key = "cognito"
        }

        "POST /auth/d/register" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /auth/p/login" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /auth/p/register" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
    }

    # authorizers= {
    #     "cognito" = {
    #         authorizer_type  = "JWT"
    #         identity_sources = "$request.header.Authorization"
    #         name             = "cognito-auth"
    #         audience = [aws_cognito_user_pool_client.client.id]
    #         issuer   = "https://${aws_cognito_user_pool.pool.endpoint}"
    #     }
    # }

    default_route_settings = {
        throttling_burst_limit   = 200
        throttling_rate_limit    = 100
    }

}

resource "aws_lambda_permission" "graphql_get_perms" {
    statement_id  = "AllowGraphQLGet"
    action        = "lambda:InvokeFunction"
    function_name = "graphql"
    principal     = "apigateway.amazonaws.com"

    source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${module.api_gateway.apigatewayv2_api_id}/*/GET/graphql"
}

resource "aws_lambda_permission" "graphql_post_perms" {
    statement_id  = "AllowGraphQLPost"
    action        = "lambda:InvokeFunction"
    function_name = "graphql"
    principal     = "apigateway.amazonaws.com"

    source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${module.api_gateway.apigatewayv2_api_id}/*/POST/graphql"
}

resource "aws_lambda_permission" "register_p_perms" {
    statement_id  = "AllowPRegister"
    action        = "lambda:InvokeFunction"
    function_name = "auth"
    principal     = "apigateway.amazonaws.com"

    source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${module.api_gateway.apigatewayv2_api_id}/*/POST/auth/p/register"
}

resource "aws_lambda_permission" "login_p_perms" {
    statement_id  = "AllowPLogin"
    action        = "lambda:InvokeFunction"
    function_name = "auth"
    principal     = "apigateway.amazonaws.com"

    source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${module.api_gateway.apigatewayv2_api_id}/*/POST/auth/p/login"
}

resource "aws_lambda_permission" "register_d_perms" {
    statement_id  = "AllowDRegister"
    action        = "lambda:InvokeFunction"
    function_name = "auth"
    principal     = "apigateway.amazonaws.com"

    source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${module.api_gateway.apigatewayv2_api_id}/*/POST/auth/d/register"
}

resource "aws_lambda_permission" "login_d_perms" {
    statement_id  = "AllowDLogin"
    action        = "lambda:InvokeFunction"
    function_name = "auth"
    principal     = "apigateway.amazonaws.com"

    source_arn = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${module.api_gateway.apigatewayv2_api_id}/*/POST/auth/d/login"
}

# authorizer
# resource "aws_cognito_user_pool" "pool" {
#     name = "api-gateway-pool"
# }

# resource "aws_cognito_user_pool_client" "client" {
#     name = "api-gateway"
#     user_pool_id = aws_cognito_user_pool.pool.id
#     explicit_auth_flows = [
#         "ALLOW_USER_PASSWORD_AUTH",
#         "ALLOW_USER_SRP_AUTH",
#         "ALLOW_REFRESH_TOKEN_AUTH"
#     ]
# }