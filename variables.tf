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
            name = "appointments",
            "route" = "ANY/dev/appointments/{proxy+}",
            "state_id" = "AllowDevAppointmentAnyProxy"
        },
        {
            name = "appointments",
            "route" = "ANY/dev/patient/appointments/{proxy+}",
            "state_id" = "AllowDevAppointmentPatientAnyProxy"
        },
        {
            name = "appointments",
            "route" = "ANY/dev/patient/appointments",
            "state_id" = "AllowDevAppointmentPatientAnyAll"
        },
        {
            name = "appointments",
            "route" = "ANY/dev/doctor/{id}/appointments",
            "state_id" = "AllowDevAvailableAppointmentDoctorAnyProxy"
        },
        {
            name = "appointments",
            "route" = "ANY/dev/doctor/appointments/{proxy+}",
            "state_id" = "AllowDevAppointmentDoctorAnyProxy"
        },
        {
            name = "appointments",
            "route" = "ANY/dev/doctor/appointments",
            "state_id" = "AllowDevAppointmentDoctorAnyAll"
        },
        {
            name = "appointments",
            "route" = "ANY/dev/doctor/slot/{proxy+}",
            "state_id" = "AllowDevSlotDoctorAnyProxy"
        },
        {
            name = "appointments",
            "route" = "ANY/dev/doctor/slot",
            "state_id" = "AllowDevSlotDoctorAnyOne"
        },
        {
            name = "appointments",
            "route" = "ANY/dev/doctor/slots",
            "state_id" = "AllowDevSlotDoctorAnyAll"
        },
        {
            name = "auth",
            "route" = "ANY/dev/auth/{proxy+}",
            "state_id" = "AllowDevAuthAnyProxy"
        },
        {
            name = "chat",
            "route" = "ANY/dev/ws/{proxy+}",
            "state_id" = "AllowDevChatAnyProxy"
        },
        {
            name = "dashboard",
            "route" = "ANY/dev/doctor/patient/{proxy+}",
            "state_id" = "AllowDevPatientAnyProxy"
        },
        {
            name = "dashboard",
            "route" = "ANY/dev/doctor/patient",
            "state_id" = "AllowDevDashboardPatientAnyAll"
        },
        {
            name = "dashboard",
            "route" = "ANY/dev/doctor/patients",
            "state_id" = "AllowDevDashboardPatientsAnyAll"
        },
        {
            name = "dashboard",
            "route" = "ANY/dev/doctor/diagnostic/{proxy+}",
            "state_id" = "AllowDevDashboardDiagnosticAnyAll"
        },
        {
            name = "dashboard",
            "route" = "ANY/dev/doctor/{proxy+}",
            "state_id" = "AllowDevDashboardDoctorAnyAll"
        },
        {
            name = "dashboard",
            "route" = "ANY/dev/doctors",
            "state_id" = "AllowDevDashboardDoctorsAnyAll"
        },
        {
            name = "diagnostic",
            "route" = "ANY/dev/diagnostic/{proxy+}",
            "state_id" = "AllowDevDiagnosticAnyAll"
        },
        {
            name = "document",
            "route" = "ANY/dev/document/{proxy+}",
            "state_id" = "AllowDevDocumentsAnyAll"
        },
        {
            name = "document",
            "route" = "ANY/dev/doctor/document/{proxy+}",
            "state_id" = "AllowDevDoctorDocumentsAnyAll"
        },
        {
            name = "double_auth",
            "route" = "ANY/dev/2fa/{proxy+}",
            "state_id" = "AllowDev2faAnyProxy"
        },
        {
            name = "double_auth",
            "route" = "ANY/dev/dashboard/2fa/{proxy+}",
            "state_id" = "AllowDevDashboard2faAnyProxy"
        },
        {
            name = "double_auth",
            "route" = "ANY/dev/dashboard/2fa",
            "state_id" = "AllowDevDashboard2faAnyOne"
        },
        {
            name = "double_auth",
            "route" = "ANY/dev/dashboard/device/{proxy+}",
            "state_id" = "AllowDevDashboardDeviceAnyProxy"
        },
        {
            name = "double_auth",
            "route" = "ANY/dev/dashboard/devices",
            "state_id" = "AllowDevDashboardDeviceAnyAll"
        },
        {
            name = "MedicalFolder",
            "route" = "ANY/dev/dashboard/medical-info",
            "state_id" = "AllowDevMedicalFolderAnyAll"
        },
        {
            name = "MedicalFolder",
            "route" = "ANY/dev/dashboard/medical-antecedent",
            "state_id" = "AllowDevMedicalAntecedentAnyAll"
        },

        {
            name = "MedicalFolder",
            "route" = "ANY/dev/dashboard/medical-antecedent/{proxy+}",
            "state_id" = "AllowDevMedicalAntecedentAnyProxy"
        },

        {
            name = "MedicalFolder",
            "route" = "ANY/demo/dashboard/medical-antecedent",
            "state_id" = "AllowDemoMedicalAntecedentAnyAll"
        },

        {
            name = "MedicalFolder",
            "route" = "ANY/demo/dashboard/medical-antecedent/{proxy+}",
            "state_id" = "AllowDemoMedicalAntecedentAnyProxy"
        },

        {
            name = "treatment",
            "route" = "ANY/dev/dashboard/treatment/{id}",
            "state_id" = "AllowDevTreatmentIdAnyOne"
        },
        {
            name = "treatment",
            "route" = "ANY/dev/dashboard/treatment",
            "state_id" = "AllowDevTreatmentAnyOne"
        },
        {
            name = "treatment",
            "route" = "ANY/dev/dashboard/treatments",
            "state_id" = "AllowDevTreatmentsAnyAll"
        },
        {
            name = "treatment_follow_up",
            "route" = "ANY/dev/dashboard/treatment/follow-up",
            "state_id" = "AllowDevTreatmentFollowUpAnyAll"
        },
        {
            name = "treatment_follow_up",
            "route" = "ANY/dev/dashboard/treatment/follow-up/{proxy+}",
            "state_id" = "AllowDevTreatmentFollowUpAnyProxy"
        },

        {
            name = "dashboard",
            "route" = "ANY/dev/dashboard/prescription",
            "state_id" = "AllowDevPrescritionAny"
        },


        // OLD VERSION


        {
            name = "auth:prod",
            "route" = "POST/auth/p/register",
            "state_id" = "AllowPRegister"
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
            name = "auth:demo",
            "route" = "POST/demo/auth/d/register",
            "state_id" = "AllowDemoDRegister"
        } ,
        {
            name       = "auth:prod",
            "route"    = "POST/auth/d/login",
            "state_id" = "AllowDLogin"
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
            name = "auth:demo",
            "route" = "POST/demo/auth/p/create_account",
            "state_id" = "AllowDemoCreatePatientAccount"
        },
        {
            name = "auth:prod",
            "route" = "POST/auth/missing-password",
            "state_id" = "AllowMissingPassword"
        },

        {
            name = "auth:demo",
            "route" = "POST/demo/auth/missing-password",
            "state_id" = "AllowDemoMissingPassword"
        },
        {
            name = "auth:prod",
            "route" = "POST/auth/reset-password",
            "state_id" = "AllowResetPassword"
        },

        {
            name = "auth:demo",
            "route" = "POST/demo/auth/reset-password",
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
            name = "nlp",
            route = "GET/nlp/status",
            "state_id": "AllowNLPStatus"
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
            name = "MedicalFolder:demo",
            "route" = "POST/demo/dashboard/medical-info",
            "state_id" = "AllowDemoMedicalinfoPOST"
        },
        {
            name = "dashboard:prod",
            "route" = "PUT/doctor/patient/{id}",
            "state_id" = "AllowMedicalinfoPUTDoctor"
        },

        {
            name = "dashboard:demo",
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
            name = "dashboard:demo",
            "route" = "GET/demo/doctor/diagnostic/waiting",
            "state_id" = "AllowDemoDoctorDiagnosticWaiting"
        },
        {
            name = "medicament",
            "route" = "ANY/dev/medicine/{proxy+}",
            "state_id" = "AllowDevMedicamentAnyProxy"
        },
        {
            name = "medicament",
            "route" = "ANY/dev/medicine",
            "state_id" = "AllowDevMedicamentAny"
        },
        {
            name = "medicament:prod",
            "route" = "POST/medicine",
            "state_id" = "AllowMedicamentPost"
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
            name = "medicament:demo",
            "route" = "GET/demo/medicine/{id}",
            "state_id" = "AllowDemoMedicamentGetOne"
        },

        {
            name = "treatment:prod",
            "route" = "POST/dashboard/treatment",
            "state_id" = "AllowTreatmentsPost"
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
            name = "treatment:demo",
            "route" = "PUT/demo/dashboard/treatment/{id}",
            "state_id" = "AllowDemoTreatmentPut"
        },

        {
            name = "treatment:prod",
            "route" = "GET/dashboard/treatments",
            "state_id" = "AllowTreatmentGetAll"
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
            name = "treatment_follow_up:demo",
            "route" = "DELETE/demo/dashboard/treatment/follow-up/{id}",
            "state_id" = "AllowDemoTreatmentFollowDelete"
        },


        {
            name       = "chat:prod",
            "route"    = "POST/ws/connection",
            "state_id" = "AllowConnectionPost"
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
            name = "chat:demo",
            "route" = "POST/demo/ws/get_messages",
            "state_id" = "AllowDemoGetMessagePost"
        },

        {
            name = "chat:prod",
            "route" = "POST/ws/read_message",
            "state_id" = "AllowReadMessagePost"
        },

        {
            name = "chat:demo",
            "route" = "POST/demo/ws/read_message",
            "state_id" = "AllowDemoReadMessagePost"
        },

        //=================================================================

        {
            name = "double_auth:prod",
            "route" = "POST/2fa/method/email",
            "state_id" = "AllowMehodEmailPost"
        },

        {
            name = "double_auth:demo",
            "route" = "POST/demo/2fa/method/email",
            "state_id" = "AllowMehodEmailDemoPost"
        },


        {
            name = "double_auth:prod",
            "route" = "POST/2fa/method/third_party",
            "state_id" = "AllowMehodThirdPartyPost"
        },

        {
            name = "double_auth:demo",
            "route" = "POST/demo/2fa/method/third_party",
            "state_id" = "AllowMehodThirdPartyDemoPost"
        },


        {
            name = "double_auth:prod",
            "route" = "POST/2fa/method/mobile",
            "state_id" = "AllowMehodMobilePost"
        },

        {
            name = "double_auth:demo",
            "route" = "POST/demo/2fa/method/mobile",
            "state_id" = "AllowMehodMobileDemoPost"
        },


        {
            name = "double_auth:prod",
            "route" = "DELETE/dashboard/2fa/{ENUM}",
            "state_id" = "DeleteDoubleAuth"
        },

        {
            name = "double_auth:demo",
            "route" = "DELETE/demo/dashboard/2fa/{ENUM}",
            "state_id" = "DeleteDemoDoubleAuth"
        },


        {
            name = "double_auth:prod",
            "route" = "GET/dashboard/2fa",
            "state_id" = "AllowGetDoubleAuth"
        },

        {
            name = "double_auth:demo",
            "route" = "GET/demo/dashboard/2fa",
            "state_id" = "AllowDemoGetDoubleAuth"
        },


        {
            name = "double_auth:prod",
            "route" = "POST/2fa/generate_code/third_party",
            "state_id" = "AllowGenerateCodeThirdParty"
        },

        {
            name = "double_auth:demo",
            "route" = "POST/demo/2fa/generate_code/third_party",
            "state_id" = "AllowDemoGenerateCodeThirdParty"
        },


        {
            name = "double_auth:prod",
            "route" = "POST/dashboard/2fa/device/{id}",
            "state_id" = "AllowDeviceId"
        },

        {
            name = "double_auth:demo",
            "route" = "POST/demo/dashboard/2fa/device/{id}",
            "state_id" = "AllowDemoDeviceId"
        },

        {
            name = "double_auth:prod",
            "route" = "GET/dashboard/2fa/device/{id}",
            "state_id" = "AllowGetDeviceIdGet"
        },

        {
            name = "double_auth:demo",
            "route" = "GET/demo/dashboard/2fa/device/{id}",
            "state_id" = "AllowDemoDeviceIdGet"
        },

        {
            name = "double_auth:prod",
            "route" = "GET/dashboard/2fa/devices",
            "state_id" = "AllowGetDevicesGet"
        },

        {
            name = "double_auth:demo",
            "route" = "GET/demo/dashboard/2fa/devices",
            "state_id" = "AllowDemoDevicesGet"
        },

        {
            name = "double_auth:prod",
            "route" = "DELETE/dashboard/2fa/device/{id}",
            "state_id" = "DeleteDeviceId"
        },

        {
            name = "double_auth:demo",
            "route" = "DELETE/demo/dashboard/2fa/device/{id}",
            "state_id" = "DeleteDemoDeviceId"
        },

        {
            name = "double_auth:prod",
            "route" = "GET/dashboard/device/{id}",
            "state_id" = "AllowGetDeviceIdTrust"
        },

        {
            name = "double_auth:demo",
            "route" = "GET/demo/dashboard/device/{id}",
            "state_id" = "GetDemoDeviceIdTrust"
        },

        {
            name = "double_auth:prod",
            "route" = "GET/dashboard/devices",
            "state_id" = "AllowGetDevicesTrust"
        },

        {
            name = "double_auth:demo",
            "route" = "GET/demo/dashboard/devices",
            "state_id" = "AllowDemoGetDevicesTrust"
        },

        {
            name = "double_auth:prod",
            "route" = "DELETE/dashboard/device/{id}",
            "state_id" = "DeleteDeviceIdTrust"
        },

        {
            name = "double_auth:demo",
            "route" = "DELETE/demo/dashboard/device/{id}",
            "state_id" = "DeleteDemoDeviceIdTrust"
        },


//=================================================================

        {
            name = "auth:prod",
            "route" = "PUT/auth/disable_account",
            "state_id" = "AllowDisableAccount"
        },

        {
            name = "auth:demo",
            "route" = "PUT/demo/auth/disable_account",
            "state_id" = "AllowDemoDisableAccount"
        },

        {
            name = "auth:prod",
            "route" = "PUT/auth/enable_account",
            "state_id" = "AllowEnableAccount"
        },

        {
            name = "auth:demo",
            "route" = "PUT/demo/auth/enable_account",
            "state_id" = "AllowDemoEnableAccount"
        },


        {
            name = "auth:prod",
            "route" = "POST/auth/creation_backup_code",
            "state_id" = "AllowECreateBackupCode"
        },

        {
            name = "auth:demo",
            "route" = "POST/demo/auth/creation_backup_code",
            "state_id" = "AllowDemoCreateBackupCode"
        },


        {
            name = "auth:prod",
            "route" = "POST/auth/update_password",
            "state_id" = "AllowUpdatePassword"
        },

        {
            name = "auth:demo",
            "route" = "POST/demo/auth/update_password",
            "state_id" = "AllowDemoUpdatePassword"
        },



        {
            name = "auth:prod",
            "route" = "POST/auth/sending_email",
            "state_id" = "AllowSendingEmail2fa"
        },

        {
            name = "auth:demo",
            "route" = "POST/demo/auth/sending_email",
            "state_id" = "AllowDemoSendingEmail2fa"
        },


        {
            name = "auth:prod",
            "route" = "POST/auth/{type}/email_2fa",
            "state_id" = "AllowLoginEmail2fa"
        },

        {
            name = "auth:demo",
            "route" = "POST/demo/auth/{type}/email_2fa",
            "state_id" = "AllowDemoLoginEmail2fa"
        },


        {
            name       = "auth:prod",
            "route"    = "POST/auth/{type}/backup_code_2fa",
            "state_id" = "AllowLoginBackupCode2fa"
        },
        {
            name = "auth:demo",
            "route" = "POST/demo/auth/{type}/backup_code_2fa",
            "state_id" = "AllowDemoLoginBackupCode2fa"
        },


        {
            name = "auth:prod",
            "route" = "POST/auth/{type}/third_party_2fa",
            "state_id" = "AllowLoginThirdParty2fa"
        },

        {
            name = "auth:demo",
            "route" = "POST/demo/auth/{type}/third_party_2fa",
            "state_id" = "AllowDemoLoginThirdParty2fa"
        },



        {
            name = "double_auth:prod",
            "route" = "POST/2fa/method/third_party/generate",
            "state_id" = "VerifyCodegenerateThirdParty"
        },

        {
            name = "double_auth:demo",
            "route" = "POST/demo/2fa/method/third_party/generate",
            "state_id" = "VerifyDemoCodegenerateThirdParty"
        },
        {
            name = "auth:prod",
            "route" = "POST/auth/{type}/mobile_2fa",
            "state_id" = "AllowProdMobile2faLog"
        },

        {
            name = "auth:demo",
            "route" = "POST/demo/auth/{type}/mobile_2fa",
            "state_id" = "AllowDemoMobile2faLog"
        },

        {
            name = "auth:prod",
            "route" = "POST/auth/ws/ready",
            "state_id" = "WebsocketProdReady2fa"
        },

        {
            name = "auth:demo",
            "route" = "POST/demo/auth/ws/ready",
            "state_id" = "WebsockerDemoReady2fa"
        },

        {
            name = "auth:prod",
            "route" = "POST/auth/ws/ask_mobile_connection",
            "state_id" = "WebsockerProdAskMobile2fa"
        },

        {
            name = "auth:demo",
            "route" = "POST/demo/auth/ws/ask_mobile_connection",
            "state_id" = "WebsockerDemoAskMobile2fa"
        },

        {
            name = "auth:prod",
            "route" = "POST/auth/ws/response_mobile_connection",
            "state_id" = "WebsocketProdResponse2fa"
        },

        {
            name = "auth:demo",
            "route" = "POST/demo/auth/ws/response_mobile_connection",
            "state_id" = "WebsocketDemoResponse2fa"
        },

        {
            name = "auth:demo",
            "route" = "POST/demo/auth/delete_account",
            "state_id" = "DeleteaccountDemo"
        },

        {
            name = "auth:prod",
            "route" = "POST/demo/auth/delete_account",
            "state_id" = "DeleteaccountProd"
        },


        {
            name = "dashboard:prod",
            "route" = "POST/dashboard/prescription",
            "state_id" = "AllowProdPrescriptionPost"
        },

        {
            name = "dashboard:demo",
            "route" = "POST/demo/dashboard/prescription",
            "state_id" = "AllowDemoPrescriptionPost"
        },

        {
            name = "dashboard:prod",
            "route" = "GET/dashboard/prescription",
            "state_id" = "AllowProdPrescriptionGet"
        },

        {
            name = "dashboard:demo",
            "route" = "GET/demo/dashboard/prescription",
            "state_id" = "AllowDemoPrescriptionGet"
        },

        {
            name = "dashboard",
            "route" = "GET/dev/dashboard/prescription/{id}",
            "state_id" = "AllowDevPrescriptionGetById"
        },

        {
            name = "dashboard:prod",
            "route" = "GET/dashboard/prescription/{id}",
            "state_id" = "AllowProdPrescriptionGetByID"
        },

        {
            name = "dashboard:demo",
            "route" = "GET/demo/dashboard/prescription/{id}",
            "state_id" = "AllowDemoPrescriptionGetByid"
        },


        {
            name = "MedicalFolder",
            "route" = "GET/dev/dashboard/medical-info/disease/{name}",
            "state_id" = "AllowGetDiseaseDevByName"
        },

        {
            name = "MedicalFolder:prod",
            "route" = "GET/dashboard/medical-info/disease/{name}",
            "state_id" = "AllowGetDiseaseProdByName"
        },

        {
            name = "MedicalFolder:demo",
            "route" = "GET/demo/dashboard/medical-info/disease/{name}",
            "state_id" = "AllowGetDiseaseDemoByName"
        },

    ]
}