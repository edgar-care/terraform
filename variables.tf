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
            name = "graphql:prod",
            "route" = "ANY/graphql/{proxy+}",
            "state_id" = "AllowGraphQLAnyProxy"
        },
        {
            name = "graphql",
            "route" = "ANY/dev/graphql/{proxy+}",
            "state_id" = "AllowDevGraphQLAnyProxy"
        },
        {
            name = "graphql:demo",
            "route" = "ANY/demo/graphql/{proxy+}",
            "state_id" = "AllowDemoGraphQLAnyProxy"
        },
        {
            name = "auth:prod",
            "route" = "POST/auth/p/register",
            "state_id" = "AllowPRegister"
        },
        {
            name = "auth",
            "route" = "POST/dev/auth/p/register",
            "state_id" = "AllowDevPRegister"
        },
        {
            name = "auth:demo",
            "route" = "POST/demo/auth/p/register",
            "state_id" = "AllowDemoPRegister"
        },
        {
            name = "auth:prod",
            "route" = "POST/auth/p/login",
            "state_id" = "AllowPLogin"
        },
        {
            name = "auth",
            "route" = "POST/dev/auth/p/login",
            "state_id" = "AllowDevPLogin"
        },
        {
            name = "auth:demo",
            "route" = "POST/demo/auth/p/login",
            "state_id" = "AllowDemoPLogin"
        },
        {
            name = "auth:prod",
            "route" = "POST/auth/d/register",
            "state_id" = "AllowDRegister"
        } ,
        {
            name = "auth",
            "route" = "POST/dev/auth/d/register",
            "state_id" = "AllowDevDRegister"
        } ,
        {
            name = "auth:demo",
            "route" = "POST/demo/auth/d/register",
            "state_id" = "AllowDemoDRegister"
        } ,
        {
            name = "auth:prod",
            "route" = "POST/auth/d/login",
            "state_id" = "AllowDLogin"
        },
        {
            name = "auth",
            "route" = "POST/dev/auth/d/login",
            "state_id" = "AllowDevDLogin"
        },
        {
            name = "auth:demo",
            "route" = "POST/demo/auth/d/login",
            "state_id" = "AllowDemoDLogin"
        },
        {
            name = "auth:prod",
            "route" = "POST/auth/a/login",
            "state_id" = "AllowALogin"
        },
        {
            name = "auth",
            "route" = "POST/dev/auth/a/login",
            "state_id" = "AllowDevALogin"
        },
        {
            name = "auth:demo",
            "route" = "POST/demo/auth/a/login",
            "state_id" = "AllowDemoALogin"
        },
        {
            name = "auth:prod",
            "route" = "POST/auth/a/register",
            "state_id" = "AllowARegister"
        } ,
        {
            name = "auth",
            "route" = "POST/dev/auth/a/register",
            "state_id" = "AllowDevARegister"
        } ,
        {
            name = "auth:demo",
            "route" = "POST/demo/auth/a/register",
            "state_id" = "AllowDemoARegister"
        } ,
        {
            name = "auth:prod",
            "route" = "POST/admin/create_account/demo",
            "state_id" = "AllowCreateDemoAccount"
        } ,
        {
            name = "auth",
            "route" = "POST/dev/admin/create_account/demo",
            "state_id" = "AllowDevCreateDemoAccount"
        } ,
        {
            name = "auth:demo",
            "route" = "POST/demo/admin/create_account/demo",
            "state_id" = "AllowDemoCreateDemoAccount"
        } ,
        {
            name = "auth:prod",
            "route" = "POST/admin/create_account/test",
            "state_id" = "AllowCreateTestAccount"
        } ,
        {
            name = "auth",
            "route" = "POST/dev/admin/create_account/test",
            "state_id" = "AllowDevCreateTestAccount"
        } ,
        {
            name = "auth:demo",
            "route" = "POST/demo/admin/create_account/test",
            "state_id" = "AllowDemoCreateTestAccount"
        } ,
        {
            name = "auth:prod",
            "route" = "POST/auth/p/create_account",
            "state_id" = "AllowCreatePatientAccount"
        },
        {
            name = "auth",
            "route" = "POST/dev/auth/p/create_account",
            "state_id" = "AllowDevCreatePatientAccount"
        },
        {
            name = "auth:demo",
            "route" = "POST/demo/auth/p/create_account",
            "state_id" = "AllowDemoCreatePatientAccount"
        },
        {
            name = "auth:prod",
            "route" = "POST/auth/p/missing-password",
            "state_id" = "AllowMissingPassword"
        },
        {
            name = "auth",
            "route" = "POST/dev/auth/p/missing-password",
            "state_id" = "AllowDevMissingPassword"
        },
        {
            name = "auth:demo",
            "route" = "POST/demo/auth/p/missing-password",
            "state_id" = "AllowDemoMissingPassword"
        },
        {
            name = "auth:prod",
            "route" = "POST/auth/p/reset-password",
            "state_id" = "AllowResetPassword"
        },
        {
            name = "auth",
            "route" = "POST/dev/auth/p/reset-password",
            "state_id" = "AllowDevResetPassword"
        },
        {
            name = "auth:demo",
            "route" = "POST/demo/auth/p/reset-password",
            "state_id" = "AllowDemoResetPassword"
        },
        {
            name = "nlp:prod",
            route = "POST/nlp",
            "state_id": "AllowNLP"
        },
        {
            name = "nlp",
            route = "POST/dev/nlp",
            "state_id": "AllowDevNLP"
        },
        {
            name = "nlp:demo",
            route = "POST/demo/nlp",
            "state_id": "AllowDemoNLP"
        },

        {
            name = "exam:prod",
            "route" = "POST/exam",
            "state_id" = "AllowExam"
        },
        {
            name = "exam",
            "route" = "POST/dev/exam",
            "state_id" = "AllowDevExam"
        },
        {
            name = "exam:demo",
            "route" = "POST/demo/exam",
            "state_id" = "AllowDemoExam"
        },

        {
            name = "diagnostic:prod",
            "route" = "POST/diagnostic/initiate",
            "state_id" = "AllowInitiate"
        },
        {
            name = "diagnostic",
            "route" = "POST/dev/diagnostic/initiate",
            "state_id" = "AllowDevInitiate"
        },
        {
            name = "diagnostic:demo",
            "route" = "POST/demo/diagnostic/initiate",
            "state_id" = "AllowDemoInitiate"
        },

        {
            name = "diagnostic:prod",
            "route" = "POST/diagnostic/diagnose",
            "state_id" = "AllowDiagnose"
        },
        {
            name = "diagnostic",
            "route" = "POST/dev/diagnostic/diagnose",
            "state_id" = "AllowDevDiagnose"
        },
        {
            name = "diagnostic:demo",
            "route" = "POST/demo/diagnostic/diagnose",
            "state_id" = "AllowDemoDiagnose"
        },

        {
            name = "diagnostic:prod",
            "route" = "GET/diagnostic/summary/{id}",
            "state_id" = "AllowDiagnosticSummary"
        },
        {
            name = "diagnostic",
            "route" = "GET/dev/diagnostic/summary/{id}",
            "state_id" = "AllowDevDiagnosticSummary"
        },
        {
            name = "diagnostic:demo",
            "route" = "GET/demo/diagnostic/summary/{id}",
            "state_id" = "AllowDemoDiagnosticSummary"
        },

        {
            name = "MedicalFolder:prod",
            "route" = "GET/dashboard/medical-info",
            "state_id" = "AllowMedicalinfoGET"
        },
        {
            name = "MedicalFolder",
            "route" = "GET/dev/dashboard/medical-info",
            "state_id" = "AllowDevMedicalinfoGET"
        },
        {
            name = "MedicalFolder:demo",
            "route" = "GET/demo/dashboard/medical-info",
            "state_id" = "AllowDemoMedicalinfoGET"
        },
        {
            name = "MedicalFolder:prod",
            "route" = "PUT/dashboard/medical-info",
            "state_id" = "AllowMedicalinfoPUT"
        },
        {
            name = "MedicalFolder",
            "route" = "PUT/dev/dashboard/medical-info",
            "state_id" = "AllowDevMedicalinfoPUT"
        },
        {
            name = "MedicalFolder:demo",
            "route" = "PUT/demo/dashboard/medical-info",
            "state_id" = "AllowDemoMedicalinfoPUT"
        },
        {
            name = "MedicalFolder:prod",
            "route" = "POST/dashboard/medical-info",
            "state_id" = "AllowMedicalinfoPOST"
        },
        {
            name = "MedicalFolder",
            "route" = "POST/dev/dashboard/medical-info",
            "state_id" = "AllowDevMedicalinfoPOST"
        },
        {
            name = "MedicalFolder:demo",
            "route" = "POST/demo/dashboard/medical-info",
            "state_id" = "AllowDemoMedicalinfoPOST"
        },
        {
            name = "MedicalFolder:prod",
            "route" = "PUT/doctor/patient/{id}",
            "state_id" = "AllowMedicalinfoPUTDoctor"
        },
        {
            name = "MedicalFolder",
            "route" = "PUT/dev/doctor/patient/{id}",
            "state_id" = "AllowDevMedicalinfoPUTDoctor"
        },
        {
            name = "MedicalFolder:demo",
            "route" = "PUT/demo/doctor/patient/{id}",
            "state_id" = "AllowDemoMedicalinfoPUTDoctor"
        },

        {
            name = "pushnotification:prod",
            "route" = "POST/push-notif",
            "state_id" = "AllowPush-notif"
        },
        {
            name = "pushnotification",
            "route" = "POST/dev/push-notif",
            "state_id" = "AllowDevPush-notif"
        },
        {
            name = "pushnotification:demo",
            "route" = "POST/demo/push-notif",
            "state_id" = "AllowDemoPush-notif"
        },
        {
            name = "document:prod",
            "route" = "POST/document/upload",
            "state_id" = "AllowDocumentUpload"
        },
        {
            name = "document",
            "route" = "POST/dev/document/upload",
            "state_id" = "AllowDevDocumentUpload"
        },
        {
            name = "document:demo",
            "route" = "POST/demo/document/upload",
            "state_id" = "AllowDemoDocumentUpload"
        },
        {
            name = "document:prod",
            "route" = "POST/document/favorite/{id}",
            "state_id" = "AllowDocumentFavorite"
        },
        {
            name = "document",
            "route" = "POST/dev/document/favorite/{id}",
            "state_id" = "AllowDevDocumentFavorite"
        },
        {
            name = "document:demo",
            "route" = "POST/demo/document/favorite/{id}",
            "state_id" = "AllowDemoDocumentFavorite"
        },
        {
            name = "document:prod",
            "route" = "POST/doctor/document/upload",
            "state_id" = "AllowDocumentUploadDoctor"
        },
        {
            name = "document",
            "route" = "POST/dev/doctor/document/upload",
            "state_id" = "AllowDevDocumentUploadDoctor"
        },
        {
            name = "document:demo",
            "route" = "POST/demo/doctor/document/upload",
            "state_id" = "AllowDemoDocumentUploadDoctor"
        },
        {
            name = "document:prod",
            "route" = "GET/document/download/{id}",
            "state_id" = "AllowDocumentDownload"
        },
        {
            name = "document",
            "route" = "GET/dev/document/download/{id}",
            "state_id" = "AllowDevDocumentDownload"
        },
        {
            name = "document:demo",
            "route" = "GET/demo/document/download/{id}",
            "state_id" = "AllowDemoDocumentDownload"
        },
        {
            name = "document:prod",
            "route" = "GET/document/download",
            "state_id" = "AllowAllDocumentDownload"
        },
        {
            name = "document",
            "route" = "GET/dev/document/download",
            "state_id" = "AllowDevAllDocumentDownload"
        },
        {
            name = "document:demo",
            "route" = "GET/demo/document/download",
            "state_id" = "AllowDemoAllDocumentDownload"
        },
        {
            name = "document:prod",
            "route" = "GET/doctor/document/{id}",
            "state_id" = "AllowAllDocumentDoctorDownload"
        },
        {
            name = "document",
            "route" = "GET/dev/doctor/document/{id}",
            "state_id" = "AllowDevAllDocumentDoctorDownload"
        },
        {
            name = "document:demo",
            "route" = "GET/demo/doctor/document/{id}",
            "state_id" = "AllowDemoAllDocumentDoctorDownload"
        },
        {
            name = "document:prod",
            "route" = "PUT/document/{id}",
            "state_id" = "AllowDocumentUpdate"
        },
        {
            name = "document",
            "route" = "PUT/dev/document/{id}",
            "state_id" = "AllowDevDocumentUpdate"
        },
        {
            name = "document:demo",
            "route" = "PUT/demo/document/{id}",
            "state_id" = "AllowDemoDocumentUpdate"
        },
        {
            name = "document:prod",
            "route" = "DELETE/document/{id}",
            "state_id" = "AllowDocumentDELETE"
        },
        {
            name = "document",
            "route" = "DELETE/dev/document/{id}",
            "state_id" = "AllowDevDocumentDELETE"
        },
        {
            name = "document:demo",
            "route" = "DELETE/demo/document/{id}",
            "state_id" = "AllowDemoDocumentDELETE"
        },
        {
            name = "document:prod",
            "route" = "DELETE/document/favorite/{id}",
            "state_id" = "AllowDocumentFavDELETE"
        },
        {
            name = "document",
            "route" = "DELETE/dev/document/favorite/{id}",
            "state_id" = "AllowDevDocumentFavDELETE"
        },
        {
            name = "document:demo",
            "route" = "DELETE/demo/document/favorite/{id}",
            "state_id" = "AllowDemoDocumentFavDELETE"
        },

        {
            name = "appointments:prod",
            "route" = "POST/doctor/slot",
            "state_id" = "AllowAppointmentsSlot"
        },
        {
            name = "appointments",
            "route" = "POST/dev/doctor/slot",
            "state_id" = "AllowDevAppointmentsSlot"
        },
        {
            name = "appointments:demo",
            "route" = "POST/demo/doctor/slot",
            "state_id" = "AllowDemoAppointmentsSlot"
        },
        {
            name = "appointments:prod",
            "route" = "GET/doctor/slot/{id}",
            "state_id" = "AllowAppointmentsSlotGETOne"
        },
        {
            name = "appointments",
            "route" = "GET/dev/doctor/slot/{id}",
            "state_id" = "AllowDevAppointmentsSlotGETOne"
        },
        {
            name = "appointments:demo",
            "route" = "GET/demo/doctor/slot/{id}",
            "state_id" = "AllowDemoAppointmentsSlotGETOne"
        },
        {
            name = "appointments:prod",
            "route" = "GET/doctor/slots",
            "state_id" = "AllowAppointmentsSlotGET"
        },
        {
            name = "appointments",
            "route" = "GET/dev/doctor/slots",
            "state_id" = "AllowDevAppointmentsSlotGET"
        },
        {
            name = "appointments:demo",
            "route" = "GET/demo/doctor/slots",
            "state_id" = "AllowDemoAppointmentsSlotGET"
        },
        {
            name = "appointments:prod",
            "route" = "DELETE/doctor/slot/{id}",
            "state_id" = "AllowAppointmentsSlotDELETE"
        },
        {
            name = "appointments",
            "route" = "DELETE/dev/doctor/slot/{id}",
            "state_id" = "AllowDevAppointmentsSlotDELETE"
        },
        {
            name = "appointments:demo",
            "route" = "DELETE/demo/doctor/slot/{id}",
            "state_id" = "AllowDemoAppointmentsSlotDELETE"
        },

        {
            name = "appointments:prod",
            "route" = "DELETE/doctor/appointments/{id}",
            "state_id" = "AllowAppointmentsDELETEDoctor"
        },
        {
            name = "appointments",
            "route" = "DELETE/dev/doctor/appointments/{id}",
            "state_id" = "AllowDevAppointmentsDELETEDoctor"
        },
        {
            name = "appointments:demo",
            "route" = "DELETE/demo/doctor/appointments/{id}",
            "state_id" = "AllowDemoAppointmentsDELETEDoctor"
        },

        {
            name = "appointments:prod",
            "route" = "POST/appointments/{id}",
            "state_id" = "AllowAppointments"
        },
        {
            name = "appointments",
            "route" = "POST/dev/appointments/{id}",
            "state_id" = "AllowDevAppointments"
        },
        {
            name = "appointments:demo",
            "route" = "POST/demo/appointments/{id}",
            "state_id" = "AllowDemoAppointments"
        },
        {
            name = "appointments:prod",
            "route" = "POST/doctor/appointments",
            "state_id" = "AllowAppointmentsDoctor"
        },
        {
            name = "appointments",
            "route" = "POST/dev/doctor/appointments",
            "state_id" = "AllowDevAppointmentsDoctor"
        },
        {
            name = "appointments:demo",
            "route" = "POST/demo/doctor/appointments",
            "state_id" = "AllowDemoAppointmentsDoctor"
        },
        {
            name = "appointments:prod",
            "route" = "PUT/appointments/{id}",
            "state_id" = "AllowAppointmentsModify"
        },
        {
            name = "appointments",
            "route" = "PUT/dev/appointments/{id}",
            "state_id" = "AllowDevAppointmentsModify"
        },
        {
            name = "appointments:demo",
            "route" = "PUT/demo/appointments/{id}",
            "state_id" = "AllowDemoAppointmentsModify"
        },
        {
            name = "appointments:prod",
            "route" = "PUT/doctor/appointments/{id}",
            "state_id" = "AllowAppointmentsDoctorModify"
        },
        {
            name = "appointments",
            "route" = "PUT/dev/doctor/appointments/{id}",
            "state_id" = "AllowDevAppointmentsDoctorModify"
        },
        {
            name = "appointments:demo",
            "route" = "PUT/demo/doctor/appointments/{id}",
            "state_id" = "AllowDemoAppointmentsDoctorModify"
        },
        {
            name = "appointments:prod",
            "route" = "GET/doctor/{id}/appointments",
            "state_id" = "AllowAppointmentsGETDoctor"
        },
        {
            name = "appointments",
            "route" = "GET/dev/doctor/{id}/appointments",
            "state_id" = "AllowDevAppointmentsGETDoctor"
        },
        {
            name = "appointments:demo",
            "route" = "GET/demo/doctor/{id}/appointments",
            "state_id" = "AllowDemoAppointmentsGETDoctor"
        },
        {
            name = "appointments:prod",
            "route" = "GET/patient/appointments",
            "state_id" = "AllowAppointmentsGETAll"
        },
        {
            name = "appointments",
            "route" = "GET/dev/patient/appointments",
            "state_id" = "AllowDevAppointmentsGETAll"
        },
        {
            name = "appointments:demo",
            "route" = "GET/demo/patient/appointments",
            "state_id" = "AllowDemoAppointmentsGETAll"
        },
        {
            name = "appointments:prod",
            "route" = "GET/patient/appointments/{id}",
            "state_id" = "AllowAppointmentsGETOne"
        },
        {
            name = "appointments",
            "route" = "GET/dev/patient/appointments/{id}",
            "state_id" = "AllowDevAppointmentsGETOne"
        },
        {
            name = "appointments:demo",
            "route" = "GET/demo/patient/appointments/{id}",
            "state_id" = "AllowDemoAppointmentsGETOne"
        },
        {
            name = "appointments:prod",
            "route" = "GET/doctor/appointments/{id}",
            "state_id" = "AllowAppointmentsGETDoctorOne"
        },
        {
            name = "appointments",
            "route" = "GET/dev/doctor/appointments/{id}",
            "state_id" = "AllowDevAppointmentsGETDoctorOne"
        },
        {
            name = "appointments:demo",
            "route" = "GET/demo/doctor/appointments/{id}",
            "state_id" = "AllowDemoAppointmentsGETDoctorOne"
        },
        {
            name = "appointments:prod",
            "route" = "GET/doctor/appointments",
            "state_id" = "AllowAppointmentsGETDoctorAll"
        },
        {
            name = "appointments",
            "route" = "GET/dev/doctor/appointments",
            "state_id" = "AllowDevAppointmentsGETDoctorAll"
        },
        {
            name = "appointments:demo",
            "route" = "GET/demo/doctor/appointments",
            "state_id" = "AllowDemoAppointmentsGETDoctorAll"
        },
        {
            name = "appointments:prod",
            "route" = "DELETE/appointments/{id}",
            "state_id" = "AllowAppointmentsDELETE"
        },
        {
            name = "appointments",
            "route" = "DELETE/dev/appointments/{id}",
            "state_id" = "AllowDevAppointmentsDELETE"
        },
        {
            name = "appointments:demo",
            "route" = "DELETE/demo/appointments/{id}",
            "state_id" = "AllowDemoAppointmentsDELETE"
        },
        {
            name = "dashboard:prod",
            "route" = "GET/doctor/patients",
            "state_id" = "AllowDashboardGetAll"
        },
        {
            name = "dashboard",
            "route" = "GET/dev/doctor/patients",
            "state_id" = "AllowDevDashboardGetAll"
        },
        {
            name = "dashboard:demo",
            "route" = "GET/demo/doctor/patients",
            "state_id" = "AllowDemoDashboardGetAll"
        },
        {
            name = "dashboard:prod",
            "route" = "GET/doctor/patient/{id}",
            "state_id" = "AllowDashboardGetone"
        },
        {
            name = "dashboard",
            "route" = "GET/dev/doctor/patient/{id}",
            "state_id" = "AllowDevDashboardGetone"
        },
        {
            name = "dashboard:demo",
            "route" = "GET/demo/doctor/patient/{id}",
            "state_id" = "AllowDemoDashboardGetone"
        },
        {
            name = "dashboard:prod",
            "route" = "DELETE/doctor/patient/{id}",
            "state_id" = "AllowDashboardDeleteone"
        },
        {
            name = "dashboard",
            "route" = "DELETE/dev/doctor/patient/{id}",
            "state_id" = "AllowDevDashboardDeleteone"
        },
        {
            name = "dashboard:demo",
            "route" = "DELETE/demo/doctor/patient/{id}",
            "state_id" = "AllowDemoDashboardDeleteone"
        },
        {
            name = "dashboard:prod",
            "route" = "POST/doctor/patient",
            "state_id" = "AllowDashboardPost"
        },
        {
            name = "dashboard",
            "route" = "POST/dev/doctor/patient",
            "state_id" = "AllowDevDashboardPost"
        },
        {
            name = "dashboard:demo",
            "route" = "POST/demo/doctor/patient",
            "state_id" = "AllowDemoDashboardPost"
        },
        {
            name = "dashboard:prod",
            "route" = "GET/doctor/{id}",
            "state_id" = "AllowDoctorId"
        },
        {
            name = "dashboard",
            "route" = "GET/dev/doctor/{id}",
            "state_id" = "AllowDevDoctorId"
        },
        {
            name = "dashboard:demo",
            "route" = "GET/demo/doctor/{id}",
            "state_id" = "AllowDemoDoctorId"
        },
        {
            name = "dashboard:prod",
            "route" = "GET/doctors",
            "state_id" = "AllowDoctors"
        },
        {
            name = "dashboard",
            "route" = "GET/dev/doctors",
            "state_id" = "AllowDevDoctors"
        },
        {
            name = "dashboard:demo",
            "route" = "GET/demo/doctors",
            "state_id" = "AllowDemoDoctors"
        },
        {
            name = "dashboard:prod",
            "route" = "POST/doctor/diagnostic/{id}",
            "state_id" = "AllowDoctorDiagnosticId"
        },
        {
            name = "dashboard",
            "route" = "POST/dev/doctor/diagnostic/{id}",
            "state_id" = "AllowDevDoctorDiagnosticId"
        },
        {
            name = "dashboard:demo",
            "route" = "POST/demo/doctor/diagnostic/{id}",
            "state_id" = "AllowDemoDoctorDiagnosticId"
        },
        {
            name = "dashboard:prod",
            "route" = "GET/doctor/diagnostic/waiting",
            "state_id" = "AllowDoctorDiagnosticWaiting"
        },
        {
            name = "dashboard",
            "route" = "GET/dev/doctor/diagnostic/waiting",
            "state_id" = "AllowDevDoctorDiagnosticWaiting"
        },
        {
            name = "dashboard:demo",
            "route" = "GET/demo/doctor/diagnostic/waiting",
            "state_id" = "AllowDemoDoctorDiagnosticWaiting"
        },
        {
            name = "medicament:prod",
            "route" = "POST/medicine",
            "state_id" = "AllowMedicamentPost"
        },
        {
            name = "medicament",
            "route" = "POST/dev/medicine",
            "state_id" = "AllowDevMedicamentPost"
        },
        {
            name = "medicament:demo",
            "route" = "POST/demo/medicine",
            "state_id" = "AllowDemoMedicamentPost"
        },
        {
            name = "medicament:prod",
            "route" = "GET/medicine",
            "state_id" = "AllowMedicamentGET"
        },
        {
            name = "medicament",
            "route" = "GET/dev/medicine",
            "state_id" = "AllowDevMedicamentGET"
        },
        {
            name = "medicament:demo",
            "route" = "GET/demo/medicine",
            "state_id" = "AllowDemoMedicamentGET"
        },
        {
            name = "medicament:prod",
            "route" = "GET/medicine/{id}",
            "state_id" = "AllowMedicamentGetOne"
        },
        {
            name = "medicament",
            "route" = "GET/dev/medicine/{id}",
            "state_id" = "AllowDevMedicamentGetOne"
        },
        {
            name = "medicament:demo",
            "route" = "GET/demo/medicine/{id}",
            "state_id" = "AllowDemoMedicamentGetOne"
        },

        {
            name = "treatment:prod",
            "route" = "POST/dashboard/treatment",
            "state_id" = "AllowTreatmentPost"
        },
        {
            name = "treatment",
            "route" = "POST/dev/dashboard/treatment",
            "state_id" = "AllowDevTreatmentPost"
        },
        {
            name = "treatment:demo",
            "route" = "POST/demo/dashboard/treatment",
            "state_id" = "AllowDemoTreatmentPost"
        },
        {
            name = "treatment:prod",
            "route" = "PUT/dashboard/treatment",
            "state_id" = "AllowTreatmentPut"
        },
        {
            name = "treatment",
            "route" = "PUT/dev/dashboard/treatment",
            "state_id" = "AllowDevTreatmentPut"
        },
        {
            name = "treatment:demo",
            "route" = "PUT/demo/dashboard/treatment",
            "state_id" = "AllowDemoTreatmentPut"
        },

        {
            name = "treatment:prod",
            "route" = "GET/dashboard/treatments",
            "state_id" = "AllowTreatmentGetAll"
        },
        {
            name = "treatment",
            "route" = "GET/dev/dashboard/treatments",
            "state_id" = "AllowDevTreatmentGetAll"
        },
        {
            name = "treatment:demo",
            "route" = "GET/demo/dashboard/treatments",
            "state_id" = "AllowDemoTreatmentGetAll"
        },

       {
            name = "treatment:prod",
            "route" = "GET/dashboard/treatment/{id}",
            "state_id" = "AllowTreatmentGetOne"
        },
        {
            name = "treatment",
            "route" = "GET/dev/dashboard/treatment/{id}",
            "state_id" = "AllowDevTreatmentGetOne"
        },
        {
            name = "treatment:demo",
            "route" = "GET/demo/dashboard/treatment/{id}",
            "state_id" = "AllowDemoTreatmentGetOne"
        },

       {
            name = "treatment:prod",
            "route" = "DELETE/dashboard/treatment/{id}",
            "state_id" = "AllowTreatmentDelete"
        },
        {
            name = "treatment",
            "route" = "DELETE/dev/dashboard/treatment/{id}",
            "state_id" = "AllowDevTreatmentDelete"
        },
        {
            name = "treatment:demo",
            "route" = "DELETE/demo/dashboard/treatment/{id}",
            "state_id" = "AllowDemoTreatmentDelete"
        },


       {
            name = "treatment_follow_up:prod",
            "route" = "POST/dashboard/treatment/follow-up",
            "state_id" = "AllowTreatmentFollowPost"
        },
        {
            name = "treatment_follow_up",
            "route" = "POST/dev/dashboard/treatment/follow-up",
            "state_id" = "AllowDevTreatmentFollowPost"
        },
        {
            name = "treatment_follow_up:demo",
            "route" = "POST/demo/dashboard/treatment/follow-up",
            "state_id" = "AllowDemoTreatmentFollowPost"
        },

       {
            name = "treatment_follow_up:prod",
            "route" = "GET/dashboard/treatment/follow-up",
            "state_id" = "AllowTreatmentFollowGetALl"
        },
        {
            name = "treatment_follow_up",
            "route" = "GET/dev/dashboard/treatment/follow-up",
            "state_id" = "AllowDevTreatmentFollowGetAll"
        },
        {
            name = "treatment_follow_up:demo",
            "route" = "GET/demo/dashboard/treatment/follow-up",
            "state_id" = "AllowDemoTreatmentFollowGetAll"
        },

       {
            name = "treatment_follow_up:prod",
            "route" = "GET/dashboard/treatment/follow-up/{id}",
            "state_id" = "AllowTreatmentFollowGetOne"
        },
        {
            name = "treatment_follow_up",
            "route" = "GET/dev/dashboard/treatment/follow-up/{id}",
            "state_id" = "AllowDevTreatmentFollowGetOne"
        },
        {
            name = "treatment_follow_up:demo",
            "route" = "GET/demo/dashboard/treatment/follow-up/{id}",
            "state_id" = "AllowDemoTreatmentFollowGetOne"
        },


       {
            name = "treatment_follow_up:prod",
            "route" = "DELETE/dashboard/treatment/follow-up/{id}",
            "state_id" = "AllowTreatmentFollowDelete"
        },
        {
            name = "treatment_follow_up",
            "route" = "DELETE/dev/dashboard/treatment/follow-up/{id}",
            "state_id" = "AllowDevTreatmentFollowDelete"
        },
        {
            name = "treatment_follow_up:demo",
            "route" = "DELETE/demo/dashboard/treatment/follow-up/{id}",
            "state_id" = "AllowDemoTreatmentFollowDelete"
        },




        {
            name = "chat:prod",
            "route" = "POST/ws/connection",
            "state_id" = "AllowConnectionPost"
        },
        {
            name = "chat",
            "route" = "POST/dev/ws/connection",
            "state_id" = "AllowDevConnectionPost"
        },
        {
            name = "chat:demo",
            "route" = "POST/demo/ws/connection",
            "state_id" = "AllowDemoConnectionPost"
        },


        {
            name = "chat:prod",
            "route" = "POST/ws/disconnect",
            "state_id" = "AllowDisconnectPost"
        },
        {
            name = "chat",
            "route" = "POST/dev/ws/disconnect",
            "state_id" = "AllowDevDisconnectPost"
        },
        {
            name = "chat:demo",
            "route" = "POST/demo/ws/disconnect",
            "state_id" = "AllowDemoDisconnectPost"
        },

        {
            name = "chat:prod",
            "route" = "POST/ws/ready",
            "state_id" = "AllowReadyPost"
        },
        {
            name = "chat",
            "route" = "POST/dev/ws/ready",
            "state_id" = "AllowDevReadyPost"
        },
        {
            name = "chat:demo",
            "route" = "POST/demo/ws/ready",
            "state_id" = "AllowDemoReadyPost"
        },


        {
            name = "chat:prod",
            "route" = "POST/ws/create_chat",
            "state_id" = "AllowCreateChatPost"
        },
        {
            name = "chat",
            "route" = "POST/dev/ws/create_chat",
            "state_id" = "AllowDevCreateChatPost"
        },
        {
            name = "chat:demo",
            "route" = "POST/demo/ws/create_chat",
            "state_id" = "AllowDemoCreateChatPost"
        },


        {
            name = "chat:prod",
            "route" = "POST/ws/send_message",
            "state_id" = "AllowSendMessagePost"
        },
        {
            name = "chat",
            "route" = "POST/dev/ws/send_message",
            "state_id" = "AllowDevSendMessagePost"
        },
        {
            name = "chat:demo",
            "route" = "POST/demo/ws/send_message",
            "state_id" = "AllowDemoSendMessagePost"
        },



        {
            name = "chat:prod",
            "route" = "POST/ws/get_messages",
            "state_id" = "AllowGetMessagesPost"
        },
        {
            name = "chat",
            "route" = "POST/dev/ws/get_messages",
            "state_id" = "AllowDevGetMessagesPost"
        },
        {
            name = "chat:demo",
            "route" = "POST/demo/ws/get_messages",
            "state_id" = "AllowDemoGetMessagesPost"
        },

        {
            name = "chat:prod",
            "route" = "POST/ws/read_message",
            "state_id" = "AllowReadMessagePost"
        },
        {
            name = "chat",
            "route" = "POST/dev/ws/read_message",
            "state_id" = "AllowDevReadMessagePost"
        },
        {
            name = "chat:demo",
            "route" = "POST/demo/ws/read_message",
            "state_id" = "AllowDemoReadMessagePost"
        },

//=============================================

        {
            name = "double_auth:prod",
            "route" = "POST/dashboard/double_auth/{id}",
            "state_id" = "AllowRDeleteDevicePost"
        },
        {
            name = "double_auth",
            "route" = "POST/dev/dashboard/double_auth/{id}",
            "state_id" = "AllowDevDeleteDevicePost"
        },
        {
            name = "double_auth:demo",
            "route" = "POST/demo/dashboard/double_auth/{id}",
            "state_id" = "AllowDemoDeleteDevicePost"
        },


        {
            name = "double_auth:prod",
            "route" = "POST/2fa/method/email",
            "state_id" = "AllowAddDoubleAutEmailPost"
        },
        {
            name = "double_auth",
            "route" = "POST/dev/2fa/method/email",
            "state_id" = "AllowDevAddDoubleAutEmailPost"
        },
        {
            name = "double_auth:demo",
            "route" = "POST/demo/2fa/method/email",
            "state_id" = "AllowDemoDAddDoubleAutEmailPost"
        },


        {
            name = "double_auth:prod",
            "route" = "POST/2fa/method/app-tier",
            "state_id" = "AllowAddDoubleAuthAppTierPost"
        },
        {
            name = "double_auth",
            "route" = "POST/dev/2fa/method/app-tier",
            "state_id" = "AllowDevAddDoubleAuthAppTierPost"
        },
        {
            name = "double_auth:demo",
            "route" = "POST/demo/2fa/method/app-tier",
            "state_id" = "AllowDemoAddDoubleAuthAppTierPost"
        },


        {
            name = "double_auth:prod",
            "route" = "POST/2fa/method/mobile",
            "state_id" = "AllowAddDoubleMobilePost"
        },
        {
            name = "double_auth",
            "route" = "POST/dev/2fa/method/mobile",
            "state_id" = "AllowDevAddDoubleMobilePost"
        },
        {
            name = "double_auth:demo",
            "route" = "POST/demo/2fa/method/mobile",
            "state_id" = "AllowDemoAddDoubleMobilePost"
        },


        {
            name = "double_auth:prod",
            "route" = "GET/dashboard/devices",
            "state_id" = "AllowGetDevicesGet"
        },
        {
            name = "double_auth",
            "route" = "GET/dev/dashboard/devices",
            "state_id" = "AllowDevGetDevicesGet"
        },
        {
            name = "double_auth:demo",
            "route" = "GET/demo/dashboard/devices",
            "state_id" = "AllowDemoGetDevicesGet"
        },


        {
            name = "double_auth:prod",
            "route" = "GET/dashboard/double_auth/{id}",
            "state_id" = "AllowGetDeviceGet"
        },
        {
            name = "double_auth",
            "route" = "GET/dev/dashboard/double_auth/{id}",
            "state_id" = "AllowDevGetDeviceGet"
        },
        {
            name = "double_auth:demo",
            "route" = "GET/demo/dashboard/double_auth/{id}",
            "state_id" = "AllowDemoGetDeviceGet"
        },


        {
            name = "double_auth:prod",
            "route" = "DELETE/dashboard/double_auth/{id}",
            "state_id" = "AllowDeleteDevice"
        },
        {
            name = "double_auth",
            "route" = "DELETE/dev/dashboard/double_auth/{id}",
            "state_id" = "AllowDevDeleteDevice"
        },
        {
            name = "double_auth:demo",
            "route" = "DELETE/demo/dashboard/double_auth/{id}",
            "state_id" = "AllowDemoDeleteDevice"
        },


        {
            name = "double_auth:prod",
            "route" = "DELETE/2fa/method/{ENUM}",
            "state_id" = "AllowDisableDoubleAuth"
        },
        {
            name = "double_auth",
            "route" = "DELETE/dev/2fa/method/{ENUM}",
            "state_id" = "AllowDevDisableDoubleAuth"
        },
        {
            name = "double_auth:demo",
            "route" = "DELETE/demo2fa/method/{ENUM}",
            "state_id" = "AllowDemoDisableDoubleAuth"
        },
    ]
}