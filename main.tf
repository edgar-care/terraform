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
  source  = "terraform-aws-modules/apigateway-v2/aws"

  name          = "edgar"
  description   = "My awesome HTTP API Gateway"
  protocol_type = "HTTP"


  cors_configuration = {
    allow_headers = ["*"]
    allow_methods = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    allow_origins = ["*"]
  }

  create_domain_name = false
  //create_domain_records = false

  # Access logs
  stage_access_log_settings = {
    create_log_group            = true
    log_group_retention_in_days = 7
    format = jsonencode({
      context = {
        domainName              = "$context.domainName"
        integrationErrorMessage = "$context.integrationErrorMessage"
        protocol                = "$context.protocol"
        requestId               = "$context.requestId"
        requestTime             = "$context.requestTime"
        responseLength          = "$context.responseLength"
        routeKey                = "$context.routeKey"
        stage                   = "$context.stage"
        status                  = "$context.status"
        error = {
          message      = "$context.error.message"
          responseType = "$context.error.responseType"
        }
        identity = {
          sourceIP = "$context.identity.sourceIp"
        }
        integration = {
          error             = "$context.integration.error"
          integrationStatus = "$context.integration.integrationStatus"
        }
      }
    })
  }


  routes = {
    "ANY /graphql/{proxy+}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "graphql:prod")
        payload_format_version = "2.0"
        timeout_milliseconds = 12000
      }
    }

    "ANY /dev/graphql/{proxy+}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "graphql")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /demo/graphql/{proxy+}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "graphql:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/doctor/appointments/{proxy+}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/doctor/appointments" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/appointments/{proxy+}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/patient/appointments/{proxy+}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/patient/appointments" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/doctor/{id}/appointments" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "appointments")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }


    "ANY /dev/doctor/slot/{proxy+}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/doctor/slot" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/doctor/slots" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/auth/{proxy+}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/ws/{proxy+}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/doctor/patient/{proxy+}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/doctor/patient" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/doctor/patients" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/doctor/diagnostic/{proxy+}" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/doctor/{proxy+}" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/doctors" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }


    "ANY /dev/diagnostic/{proxy+}" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "diagnostic")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }
    "ANY /dev/document/{proxy+}" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "document")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/doctor/document/{proxy+}" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "document")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }


    "ANY /dev/2fa/{proxy+}" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "double_auth")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/dashboard/2fa/{proxy+}" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "double_auth")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/dashboard/2fa" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "double_auth")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/dashboard/device/{proxy+}" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "double_auth")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/dashboard/devices" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "double_auth")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/dashboard/medical-info" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "MedicalFolder")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/dashboard/medical-antecedent" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "MedicalFolder")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/dashboard/medical-antecedent/{proxy+}" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "MedicalFolder")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }



    "ANY /demo/dashboard/medical-antecedent" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "MedicalFolder")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /demo/dashboard/medical-antecedent/{proxy+}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "MedicalFolder")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }



    "ANY /dev/dashboard/treatment/{id}" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "treatment")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/dashboard/treatment" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "treatment")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/dashboard/treatments" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "treatment")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }


    "ANY /dev/dashboard/treatment/follow-up" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "treatment_follow_up")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/dashboard/treatment/follow-up/{proxy+}" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "treatment_follow_up")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }

    "ANY /dev/dashboard/prescription" = {
        integration = {
            uri = format("%s%s", var.base_lambda_arn, "dashboard")
            payload_format_version = "2.0"
            timeout_milliseconds   = 12000
        }
    }


    #=============================

    "POST /auth/a/login" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /demo/auth/a/login" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /auth/a/register" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /demo/auth/a/register" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /auth/d/login" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /demo/auth/d/login" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /auth/d/register" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /demo/auth/d/register" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /auth/p/login" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /demo/auth/p/login" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /auth/p/register" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/auth/p/register" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /admin/create_account/demo" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/admin/create_account/demo" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /admin/create_account/test" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/admin/create_account/test" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /auth/p/create_account" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/auth/p/create_account" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /auth/missing-password" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/auth/missing-password" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /auth/reset-password" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/auth/reset-password" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /nlp" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "nlp:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/nlp" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "nlp:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /dev/nlp" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "nlp")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /status" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "nlp")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /exam" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "exam:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/exam" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "exam:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /dev/exam" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "exam")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /diagnostic/diagnose" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "diagnostic:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/diagnostic/diagnose" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "diagnostic:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /doctor/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/doctor/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /doctors" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /demo/doctors" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /doctor/diagnostic/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /demo/doctor/diagnostic/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /doctor/diagnostic/waiting" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /demo/doctor/diagnostic/waiting" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /dashboard/medical-info" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "MedicalFolder:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/dashboard/medical-info" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "MedicalFolder:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "PUT /dashboard/medical-info" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "MedicalFolder:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "PUT /demo/dashboard/medical-info" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "MedicalFolder:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }



    "POST /dashboard/medical-info" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "MedicalFolder:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/dashboard/medical-info" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "MedicalFolder:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "PUT /doctor/patient/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "PUT /demo/doctor/patient/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /push-notif" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "pushnotification:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/push-notif" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "pushnotification:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /dev/push-notif" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "pushnotification")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /document/upload" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/document/upload" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /document/favorite/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/document/favorite/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /doctor/document/upload" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/doctor/document/upload" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /document/download/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/document/download/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /document/download" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/document/download" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /doctor/document/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/doctor/document/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "PUT /document/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "PUT /demo/document/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "DELETE /document/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "DELETE /demo/document/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "DELETE /document/favorite/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "DELETE /demo/document/favorite/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "document:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /doctor/slot" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/doctor/slot" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /doctor/slot/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/doctor/slot/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /doctor/slots" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/doctor/slots" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "DELETE /doctor/slot/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "DELETE /demo/doctor/slot/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /doctor/appointments" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/doctor/appointments" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "PUT /appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "PUT /demo/appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "PUT /doctor/appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "PUT /demo/doctor/appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /doctor/{id}/appointments" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/doctor/{id}/appointments" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /patient/appointments" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/patient/appointments" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /patient/appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/patient/appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /doctor/appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/doctor/appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /doctor/appointments" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/doctor/appointments" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "DELETE /appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "DELETE /demo/appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /diagnostic/initiate" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "diagnostic:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/diagnostic/initiate" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "diagnostic:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /diagnostic/summary/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "diagnostic:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/diagnostic/summary/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "diagnostic:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "DELETE /doctor/appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "DELETE /demo/doctor/appointments/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "appointments:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /doctor/patient/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/doctor/patient/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /doctor/patients" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /demo/doctor/patients" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /doctor/patient" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/doctor/patient" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }



    "DELETE /doctor/patient/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "DELETE /demo/doctor/patient/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }



    "ANY /dev/medicine/{proxy+}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "medicament")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "ANY /dev/medicine" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "medicament")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /medicine" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "medicament:prod")
        payload_format_version = "2.0"
      }
    }



    "POST /demo/medicine" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "medicament:demo")
        payload_format_version = "2.0"
      }
    }

    "GET /medicine" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "medicament:prod")
        payload_format_version = "2.0"
      }
    }


    "GET /demo/medicine" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "medicament:demo")
        payload_format_version = "2.0"
      }
    }

    "GET /medicine/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "medicament:prod")
        payload_format_version = "2.0"
      }
    }


    "GET /demo/medicine/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "medicament:demo")
        payload_format_version = "2.0"
      }
    }

    "POST /dashboard/treatment" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/dashboard/treatment" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment:demo")
        payload_format_version = "2.0"
      }
    }

    "PUT /dashboard/treatment" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment:prod")
        payload_format_version = "2.0"
      }
    }

    "PUT /demo/dashboard/treatment/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment:demo")
        payload_format_version = "2.0"
      }
    }
    "GET /dashboard/treatments" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment:prod")
        payload_format_version = "2.0"
      }
    }

    "GET /demo/dashboard/treatments" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment:demo")
        payload_format_version = "2.0"
      }
    }
    "GET /dashboard/treatment/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment:prod")
        payload_format_version = "2.0"
      }
    }

    "GET /demo/dashboard/treatment/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment:demo")
        payload_format_version = "2.0"
      }
    }

    "DELETE /dashboard/treatment/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment:prod")
        payload_format_version = "2.0"
      }
    }

    "DELETE /demo/dashboard/treatment/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /dashboard/treatment/follow-up" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment_follow_up:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/dashboard/treatment/follow-up" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment_follow_up:demo")
        payload_format_version = "2.0"
      }
    }


    "GET /dashboard/treatment/follow-up" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment_follow_up:prod")
        payload_format_version = "2.0"
      }
    }

    "GET /demo/dashboard/treatment/follow-up" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment_follow_up:demo")
        payload_format_version = "2.0"
      }
    }


    "GET /dashboard/treatment/follow-up/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment_follow_up:prod")
        payload_format_version = "2.0"
      }
    }

    "GET /demo/dashboard/treatment/follow-up/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment_follow_up:demo")
        payload_format_version = "2.0"
      }
    }


    "DELETE /dashboard/treatment/follow-up/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment_follow_up:prod")
        payload_format_version = "2.0"
      }
    }

    "DELETE /demo/dashboard/treatment/follow-up/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "treatment_follow_up:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /ws/connection" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/ws/connection" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /ws/disconnect" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/ws/disconnect" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /ws/ready" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/ws/ready" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /ws/create_chat" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:prod")
        payload_format_version = "2.0"
      }
    }
    "POST /demo/ws/create_chat" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /ws/send_message" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/ws/send_message" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /ws/get_messages" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/ws/get_messages" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /ws/read_message" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/ws/read_message" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "chat:demo")
        payload_format_version = "2.0"
      }
    }

    "POST /2fa/method/email" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/2fa/method/email" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /2fa/method/third_party" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/2fa/method/third_party" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /2fa/method/mobile" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/2fa/method/mobile" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }

    "DELETE /dashboard/2fa/{ENUM}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "DELETE /demo/dashboard/2fa/{ENUM}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }


    "GET /dashboard/2fa" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "GET /demo/dashboard/2fa" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /2fa/generate_code/third_party" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/2fa/generate_code/third_party" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /dashboard/2fa/device/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/dashboard/2fa/device/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }


    "GET /dashboard/2fa/device/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "GET /demo/dashboard/2fa/device/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }

    "GET /dashboard/2fa/devices" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "GET /demo/dashboard/2fa/devices" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }

    "DELETE /dashboard/2fa/device/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "DELETE /demo/dashboard/2fa/device/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }

    "GET /dashboard/device/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "GET /demo/dashboard/device/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }

    "GET /dashboard/devices" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "GET /demo/dashboard/devices" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }


    "DELETE /dashboard/device/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "DELETE /demo/dashboard/device/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }


    "PUT /auth/disable_account" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
      }
    }


    "PUT /demo/auth/disable_account" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
      }
    }

    "POST /auth/creation_backup_code" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
      }
    }


    "POST /demo/auth/creation_backup_code" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
      }
    }


    "PUT /auth/enable_account" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
      }
    }



    "PUT /demo/auth/enable_account" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
      }
    }



    "POST /auth/update_password" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
      }
    }


    "POST /demo/auth/update_password" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /auth/sending_email" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/auth/sending_email" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /auth/{type}/email_2fa" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /demo/auth/{type}/email_2fa" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }



    "POST /auth/{type}/backup_code_2fa" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }



    "POST /demo/auth/{type}/backup_code_2fa" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }



    "POST /auth/{type}/third_party_2fa" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "POST /demo/auth/{type}/third_party_2fa" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }



    "POST /2fa/method/third_party/generate" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:prod")
        payload_format_version = "2.0"
      }
    }

    "POST /demo/2fa/method/third_party/generate" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "double_auth:demo")
        payload_format_version = "2.0"
      }
    }

    "POST /auth/{type}/mobile_2fa" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
      }
    }


    "POST /demo/auth/{type}/mobile_2fa" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /auth/ws/ready" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
      }
    }


    "POST /demo/auth/ws/ready" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /auth/ws/ask_mobile_connection" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
      }
    }


    "POST /demo/auth/ws/ask_mobile_connection" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /auth/ws/response_mobile_connection" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:prod")
        payload_format_version = "2.0"
      }
    }


    "POST /demo/auth/ws/response_mobile_connection" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "auth:demo")
        payload_format_version = "2.0"
      }
    }


    "POST /dashboard/prescription" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "POST /demo/dashboard/prescription" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /dashboard/prescription" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /demo/dashboard/prescription" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /dashboard/prescription/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /demo/dashboard/prescription/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /dev/dashboard/prescription/{id}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "dashboard")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /dashboard/medical-info/disease/{name}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "MedicalFolder:prod")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }


    "GET /demo/dashboard/medical-info/disease/{name}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "MedicalFolder:demo")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

    "GET /dev/dashboard/medical-info/disease/{name}" = {
      integration = {
        uri = format("%s%s", var.base_lambda_arn, "MedicalFolder")
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }

  }
  #hosted_zone_id         = data.aws_route53_zone.this.id

    # integrations = {
    #     "GET /graphql" = {
    #         lambda_arn             = format("%s%s", var.base_lambda_arn, "graphql")
    #         payload_format_version = "2.0"
    #         timeout_milliseconds   = 12000
    #         // authorizer_key = "cognito"
    #     }
    # }
}

resource "aws_cloudwatch_log_group" "api_gateway_access_log" {
  name              = "/aws/apigateway/edgar"
  retention_in_days = 120
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