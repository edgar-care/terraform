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

    name          = "edgar"
    description   = "HTTP Api Gateway for edgar"
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
        "ANY /graphql/{proxy+}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "graphql:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "ANY /dev/graphql/{proxy+}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "graphql")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "ANY /demo/graphql/{proxy+}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "graphql:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /auth/a/login" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/auth/a/login" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/auth/a/login" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /auth/a/register" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/auth/a/register" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/auth/a/register" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /auth/d/login" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/auth/d/login" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/auth/d/login" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /auth/d/register" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/auth/d/register" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/auth/d/register" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /auth/p/login" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/auth/p/login" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/auth/p/login" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /auth/p/register" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/auth/p/register" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        
        "POST /dev/auth/p/register" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /admin/create_account/demo" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/admin/create_account/demo" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        
        "POST /dev/admin/create_account/demo" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        
        "POST /admin/create_account/test" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/admin/create_account/test" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        
        "POST /dev/admin/create_account/test" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /auth/p/create_account" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/auth/p/create_account" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/auth/p/create_account" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /auth/p/missing-password" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/auth/p/missing-password" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/auth/p/missing-password" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /auth/p/reset-password" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/auth/p/reset-password" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/auth/p/reset-password" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "auth")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /nlp" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "nlp:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        "POST /demo/nlp" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "nlp:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        
        "POST /dev/nlp" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "nlp")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /exam" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "exam:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/exam" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "exam:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        
        "POST /dev/exam" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "exam")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /diagnostic/diagnose" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "diagnostic:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/diagnostic/diagnose" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "diagnostic:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/diagnostic/diagnose" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "diagnostic")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /doctor/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/doctor/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        "GET /demo/doctor/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /doctors" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/doctors" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        "GET /demo/doctors" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /doctor/diagnostic/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/doctor/diagnostic/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        "POST /demo/doctor/diagnostic/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /doctor/diagnostic/waiting" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/doctor/diagnostic/waiting" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        "GET /demo/doctor/diagnostic/waiting" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dashboard/medical-info" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "MedicalFolder:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/dashboard/medical-info" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "MedicalFolder:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/dashboard/medical-info" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "MedicalFolder")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /dashboard/medical-info" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "MedicalFolder:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /demo/dashboard/medical-info" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "MedicalFolder:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /dev/dashboard/medical-info" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "MedicalFolder")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dashboard/medical-info" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "MedicalFolder:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/dashboard/medical-info" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "MedicalFolder:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/dashboard/medical-info" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "MedicalFolder")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /doctor/patient/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "MedicalFolder:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /demo/doctor/patient/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "MedicalFolder:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /dev/doctor/patient/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "MedicalFolder")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /push-notif" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "pushnotification:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/push-notif" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "pushnotification:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/push-notif" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "pushnotification")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /document/upload" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/document/upload" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/document/upload" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /document/favorite/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/document/favorite/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/document/favorite/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /doctor/document/upload" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/doctor/document/upload" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/doctor/document/upload" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        
        "GET /document/download/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/document/download/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/document/download/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /document/download" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/document/download" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/document/download" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /doctor/document/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/doctor/document/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/doctor/document/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /document/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /demo/document/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /dev/document/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /document/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /demo/document/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        "DELETE /dev/document/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        
        "DELETE /document/favorite/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /demo/document/favorite/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /dev/document/favorite/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "document")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /doctor/slot" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/doctor/slot" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        "POST /dev/doctor/slot" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /doctor/slot/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/doctor/slot/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/doctor/slot/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /doctor/slots" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/doctor/slots" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/doctor/slots" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /doctor/slot/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /demo/doctor/slot/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /dev/doctor/slot/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /doctor/appointments" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/doctor/appointments" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/doctor/appointments" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /demo/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /dev/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /doctor/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        
        "PUT /demo/doctor/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "PUT /dev/doctor/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /doctor/{id}/appointments" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/doctor/{id}/appointments" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/doctor/{id}/appointments" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /patient/appointments" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/patient/appointments" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/patient/appointments" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /patient/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/patient/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/patient/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /doctor/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/doctor/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/doctor/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /doctor/appointments" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/doctor/appointments" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/doctor/appointments" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /demo/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /dev/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /diagnostic/initiate" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "diagnostic:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /demo/diagnostic/initiate" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "diagnostic:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/diagnostic/initiate" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "diagnostic")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /diagnostic/summary/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "diagnostic:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/diagnostic/summary/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "diagnostic:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/diagnostic/summary/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "diagnostic")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /doctor/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /demo/doctor/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /dev/doctor/appointments/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /doctor/patient/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/doctor/patient/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/doctor/patient/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /doctor/patients" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /demo/doctor/patients" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "GET /dev/doctor/patients" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /doctor/patient" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }
        
        "POST /demo/doctor/patient" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /dev/doctor/patient" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /doctor/patient/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:prod")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /demo/doctor/patient/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard:demo")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "DELETE /dev/doctor/patient/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds = 12000
        }

        "POST /medicine" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "medicament:prod")
            payload_format_version = "2.0"
        }

        "POST /dev/medicine" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "medicament")
            payload_format_version = "2.0"
        }

        "POST /demo/medicine" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "medicament:demo")
            payload_format_version = "2.0"
        }

        "GET /medicine" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "medicament:prod")
            payload_format_version = "2.0"
        }

        "GET /dev/medicine" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "medicament")
            payload_format_version = "2.0"
        }

        "GET /demo/medicine" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "medicament:demo")
            payload_format_version = "2.0"
        }

        "GET /medicine/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "medicament:prod")
            payload_format_version = "2.0"
        }

        "GET /dev/medicine/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "medicament")
            payload_format_version = "2.0"
        }

        "GET /demo/medicine/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "medicament:demo")
            payload_format_version = "2.0"
        }

        "POST /dashboard/treatment" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment:prod")
                payload_format_version = "2.0"
        }
        "POST /dev/dashboard/treatment" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment")
                payload_format_version = "2.0"
        }
        "POST /demo/dashboard/treatment" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment:demo")
                payload_format_version = "2.0"
        }

        "PUT /dashboard/treatment" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment:prod")
                payload_format_version = "2.0"
        }
        "PUT /dev/dashboard/treatment" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment")
                payload_format_version = "2.0"
        }
        "PUT /demo/dashboard/treatment" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment:demo")
                payload_format_version = "2.0"
        }
        "GET /dashboard/treatments" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment:prod")
                payload_format_version = "2.0"
        }
        "GET /dev/dashboard/treatments" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment")
                payload_format_version = "2.0"
        }
        "GET /demo/dashboard/treatments" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment:demo")
                payload_format_version = "2.0"
        }
        "GET /dashboard/treatment/{id}" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment:prod")
                payload_format_version = "2.0"
        }
        "GET /dev/dashboard/treatment/{id}" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment")
                payload_format_version = "2.0"
        }
        "GET /demo/dashboard/treatment/{id}" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment:demo")
                payload_format_version = "2.0"
        }

        "DELETE /dashboard/treatment/{id}" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment:prod")
                payload_format_version = "2.0"
        }
        "DELETE /dev/dashboard/treatment/{id}" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment")
                payload_format_version = "2.0"
        }
        "DELETE /demo/dashboard/treatment/{id}" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment:demo")
                payload_format_version = "2.0"
        }


        "POST /dashboard/treatment/follow-up" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment_follow_up:prod")
                payload_format_version = "2.0"
        }
        "POST /dev/dashboard/treatment/follow-up" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment_follow_up")
                payload_format_version = "2.0"
        }
        "POST /demo/dashboard/treatment/follow-up" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment_follow_up:demo")
                payload_format_version = "2.0"
        }


        "GET /dashboard/treatment/follow-up" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment_follow_up:prod")
                payload_format_version = "2.0"
        }
        "GET /dev/dashboard/treatment/follow-up" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment_follow_up")
                payload_format_version = "2.0"
        }
        "GET /demo/dashboard/treatment/follow-up" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment_follow_up:demo")
                payload_format_version = "2.0"
        }


        "GET /dashboard/treatment/follow-up/{id}" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment_follow_up:prod")
                payload_format_version = "2.0"
        }
        "GET /dev/dashboard/treatment/follow-up/{id}" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment_follow_up")
                payload_format_version = "2.0"
        }
        "GET /demo/dashboard/treatment/follow-up/{id}" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment_follow_up:demo")
                payload_format_version = "2.0"
        }


        "DELETE /dashboard/treatment/follow-up/{id}" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment_follow_up:prod")
                payload_format_version = "2.0"
        }
        "DELETE /dev/dashboard/treatment/follow-up/{id}" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment_follow_up")
                payload_format_version = "2.0"
        }
        "DELETE /demo/dashboard/treatment/follow-up/{id}" = {
                lambda_arn = format("%s%s", var.base_lambda_arn, "treatment_follow_up:demo")
                payload_format_version = "2.0"
        }


        "POST /ws/connection" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat:prod")
            payload_format_version = "2.0"
        }
        "POST /dev/ws/connection" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat")
            payload_format_version = "2.0"
        }
        "POST /demo/ws/connection" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat:demo")
            payload_format_version = "2.0"
        }


        "POST /ws/disconnect" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat:prod")
            payload_format_version = "2.0"
        }
        "POST /dev/ws/disconnect" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat")
            payload_format_version = "2.0"
        }
        "POST /demo/ws/disconnect" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat:demo")
            payload_format_version = "2.0"
        }


        "POST /ws/ready" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat:prod")
            payload_format_version = "2.0"
        }
        "POST /dev/ws/ready" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat")
            payload_format_version = "2.0"
        }
        "POST /demo/ws/ready" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat:demo")
            payload_format_version = "2.0"
        }


        "POST /ws/create_chat" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat:prod")
            payload_format_version = "2.0"
        }
        "POST /dev/ws/create_chat" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat")
            payload_format_version = "2.0"
        }
        "POST /demo/ws/create_chat" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat:demo")
            payload_format_version = "2.0"
        }


        "POST /ws/send_message" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat:prod")
            payload_format_version = "2.0"
        }
        "POST /dev/ws/send_message" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat")
            payload_format_version = "2.0"
        }
        "POST /demo/ws/send_message" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat:demo")
            payload_format_version = "2.0"
        }


        "POST /ws/get_messages" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat:prod")
            payload_format_version = "2.0"
        }
        "POST /dev/ws/get_messages" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat")
            payload_format_version = "2.0"
        }
        "POST /demo/ws/get_messages" = {
            lambda_arn             = format("%s%s", var.base_lambda_arn, "chat:demo")
            payload_format_version = "2.0"
        }


        "POST /ws/read_message" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat:prod")
            payload_format_version = "2.0"
        }
        "POST /dev/ws/read_message" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat")
            payload_format_version = "2.0"
        }
        "POST /demo/ws/read_message" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "chat:demo")
            payload_format_version = "2.0"
        }
//======================================================================

        "POST /dashboard/double_auth/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:prod")
            payload_format_version = "2.0"
        }
        "POST /dev/dashboard/double_auth/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth")
            payload_format_version = "2.0"
        }
        "POST /demo/dashboard/double_auth/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:demo")
            payload_format_version = "2.0"
        }


        "POST /2fa/method/email" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:prod")
            payload_format_version = "2.0"
        }
        "POST /dev/2fa/method/email" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth")
            payload_format_version = "2.0"
        }
        "POST /demo/2fa/method/email" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:demo")
            payload_format_version = "2.0"
        }


        "POST /2fa/method/app-tier" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:prod")
            payload_format_version = "2.0"
        }
        "POST /dev/2fa/method/app-tier" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth")
            payload_format_version = "2.0"
        }
        "POST /demo/2fa/method/app-tier" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:demo")
            payload_format_version = "2.0"
        }


        "POST /2fa/method/mobile" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:prod")
            payload_format_version = "2.0"
        }
        "POST /dev/2fa/method/mobile" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth")
            payload_format_version = "2.0"
        }
        "POST /demo/2fa/method/mobile" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:demo")
            payload_format_version = "2.0"
        }


        "GET /dashboard/devices" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:prod")
            payload_format_version = "2.0"
        }
        "GET /dev/dashboard/devices" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth")
            payload_format_version = "2.0"
        }
        "GET /demo/dashboard/devices" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:demo")
            payload_format_version = "2.0"
        }


        "GET /dashboard/double_auth/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:prod")
            payload_format_version = "2.0"
        }
        "GET /dev/dashboard/double_auth/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth")
            payload_format_version = "2.0"
        }
        "GET /demo/dashboard/double_auth/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:demo")
            payload_format_version = "2.0"
        }


        "DELETE /dashboard/double_auth/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:prod")
            payload_format_version = "2.0"
        }
        "DELETE /dev/dashboard/double_auth/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth")
            payload_format_version = "2.0"
        }
        "DELETE /demo/dashboard/double_auth/{id}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:demo")
            payload_format_version = "2.0"
        }


        "DELETE /2fa/method/{ENUM}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:prod")
            payload_format_version = "2.0"
        }
        "DELETE /dev/2fa/method/{ENUM}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth")
            payload_format_version = "2.0"
        }
        "DELETE /demo/2fa/method/{ENUM}" = {
            lambda_arn = format("%s%s", var.base_lambda_arn, "double_auth:demo")
            payload_format_version = "2.0"
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