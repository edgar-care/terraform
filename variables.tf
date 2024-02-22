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
            "route" = "ANY/graphql/{proxy+}",
            "state_id" = "AllowGraphQLAnyProxy"

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
            name = "auth",
            "route" = "POST/admin/create_account/demo",
            "state_id" = "AllowCreateDemoAccount"
        } ,
        {
            name = "auth",
            "route" = "POST/admin/create_account/test",
            "state_id" = "AllowCreateTestAccount"
        } ,
        {
            name = "auth",
            "route" = "POST/auth/p/create_account",
            "state_id" = "AllowCreatePatientAccount"
        },
        {
            name = "auth",
            "route" = "POST/auth/p/missing-password",
            "state_id" = "AllowMissingPassword"
        },
        {
            name = "auth",
            "route" = "POST/auth/p/reset-password",
            "state_id" = "AllowResetPassword"
        },
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
            name = "diagnostic",
            "route" = "GET/diagnostic/summary/{id}",
            "state_id" = "AllowDiagnosticSummary"
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
            "route" = "GET/document/download",
            "state_id" = "AllowAllDocumentDownload"
        },
        {
            name = "document",
            "route" = "PUT/document/{id}",
            "state_id" = "AllowDocumentUpdate"
        },
        {
            name = "document",
            "route" = "DELETE/document/{id}",
            "state_id" = "AllowDocumentDELETE"
        },
        {
            name = "document",
            "route" = "DELETE/document/favorite/{id}",
            "state_id" = "AllowDocumentFavDELETE"
        },

        {
            name = "appointments",
            "route" = "POST/doctor/slot",
            "state_id" = "AllowAppointmentsSlot"
        },
        {
            name = "appointments",
            "route" = "GET/doctor/slot/{id}",
            "state_id" = "AllowAppointmentsSlotGETOne"
        },
        {
            name = "appointments",
            "route" = "GET/doctor/slots",
            "state_id" = "AllowAppointmentsSlotGET"
        },
        {
            name = "appointments",
            "route" = "DELETE/doctor/slot/{id}",
            "state_id" = "AllowAppointmentsSlotDELETE"
        },

        {
            name = "appointments",
            "route" = "DELETE/doctor/appointments/{id}",
            "state_id" = "AllowAppointmentsDELETEDoctor"
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
        {
            name = "dashboard",
            "route" = "GET/doctor/patients",
            "state_id" = "AllowDashboardGetAll"
        },
        {
            name = "dashboard",
            "route" = "GET/doctor/patient/{id}",
            "state_id" = "AllowDashboardGetone"
        },
        {
            name = "dashboard",
            "route" = "DELETE/doctor/patient/{id}",
            "state_id" = "AllowDashboardDeleteone"
        },
        {
            name = "onboarding",
            "route" = "PUT/doctor/patient/{id}",
            "state_id" = "AllowDashboardUpdateOnboarding"
        },
        {
            name = "dashboard",
            "route" = "POST/doctor/patient",
            "state_id" = "AllowDashboardPost"
        },
    ]
}