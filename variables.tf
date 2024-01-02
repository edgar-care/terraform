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
        # {
        #     name = "nlp",
        #     route = "POST/nlp",
        #     "state_id": "AllowNLP"
        # },

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
            name = "onboarding",
            "route" = "GET/dashboard/medical-info",
            "state_id" = "AllowMedical-infoGET"
        },
        {
            name = "onboarding",
            "route" = "PUT/dashboard/medical-info",
            "state_id" = "AllowMedical-infoPUT"
        },

        {
            name = "pushnotification",
            "route" = "POST/push-notif",
            "state_id" = "AllowPush-notif"
        },
        {
            name = "document",
            "route" = "POST/document/upload",
            "state_id" = "AllowDocumentUpload"
        },
        {
            name = "document",
            "route" = "POST/document/favorite/{id}",
            "state_id" = "AllowDocumentFavorite"
        },
        {
            name = "document",
            "route" = "GET/document/download/{id}",
            "state_id" = "AllowDocumentDownload"
        },
        {
            name = "document",
            "route" = "DELETE/document/{id}",
            "state_id" = "AllowDocumentDELETE"
        },

        {
            name = "slot",
            "route" = "POST/doctor/slot",
            "state_id" = "AllowSlot"
        },
        {
            name = "slot",
            "route" = "GET/doctor/slot/{id}",
            "state_id" = "AllowSlotGETOne"
        },
        {
            name = "slot",
            "route" = "GET/doctor/slots",
            "state_id" = "AllowSlotGET"
        },
        {
            name = "slot",
            "route" = "DELETE/doctor/slot/{id}",
            "state_id" = "AllowSlotDELETE"
        },

        {
            name = "appointments",
            "route" = "POST/appointments/{id}",
            "state_id" = "AllowAppointments"
        },
        {
            name = "appointments",
            "route" = "POST/doctor/appointments",
            "state_id" = "AllowAppointmentsDoctor"
        },
        {
            name = "appointments",
            "route" = "PUT/appointments/{id}",
            "state_id" = "AllowAppointmentsModify"
        },
        {
            name = "appointments",
            "route" = "PUT/doctor/appointments/{id}",
            "state_id" = "AllowAppointmentsDoctorModify"
        },
        {
            name = "appointments",
            "route" = "GET/doctor/{id}/appointments",
            "state_id" = "AllowAppointmentsGETDoctor"
        },
        {
            name = "appointments",
            "route" = "GET/patient/appointments",
            "state_id" = "AllowAppointmentsGETAll"
        },
        {
            name = "appointments",
            "route" = "GET/patient/appointments/{id}",
            "state_id" = "AllowAppointmentsGETOne"
        },
        {
            name = "appointments",
            "route" = "GET/doctor/appointments/{id}",
            "state_id" = "AllowAppointmentsGETDoctorOne"
        },
        {
            name = "appointments",
            "route" = "GET/doctor/appointments",
            "state_id" = "AllowAppointmentsGETDoctorAll"
        },
        {
            name = "appointments",
            "route" = "DELETE/appointments/{id}",
            "state_id" = "AllowAppointmentsDELETE"
        },
    ]
}