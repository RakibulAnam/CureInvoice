//
//  Constants.swift
//  CareInvoice
//
//  Created by Jotno on 9/12/23.
//

import Foundation


struct K{
    
    static let CREATE_ORGANIZATION = "\(base.BASE_URL)/organization/create"
    static let UPDATE_ORGANIZATION = "\(base.BASE_URL)/organization/updateOrganizationProfile/"
    static let GET_ORGANIZATION_BY_ID = "\(base.BASE_URL)/organization/getOrganizationById/"
    static let GET_ROLE = "\(base.BASE_URL)/getRole"
    
    static let GET_ALL_SPECIALITY_GLOBAL = "\(base.BASE_URL)/specialist/getAllSpecialist"
    static let ADD_SPECIALITY = "\(base.BASE_URL)/specialist/addSpeciality"
    static let UPDATE_SPECIALITY_BY_ID = "\(base.BASE_URL)/specialist/updateSpeciality/"
    static let GET_ALL_SPECIALITY_BY_ORG = "\(base.BASE_URL)/specialist/getAllSpecialist"
    static let GET_SPECIALITY_BY_NAME = "\(base.BASE_URL)/specialist/search/"
    
    static let GET_ALL_DRUGS_BY_ORG = "\(base.BASE_URL)/drugs/getAllDrugs/"
    static let GET_ALL_DRUGS_GLOBAL = "\(base.BASE_URL)/drugs/getAllDrugs"
    static let CREATE_DRUG = "\(base.BASE_URL)/drugs/addDrug"
    static let UPDATE_DRUG = "\(base.BASE_URL)/drugs/updateDrug/"
    static let UPDATE_DRUG_FOR_ORG = "\(base.BASE_URL)/drugs/updatePriceAndQuantity"
    static let SEARCH_DRUGS_DURING_ORDER = "\(base.BASE_URL)/drugs/searchDrugByBrandNameAndOrgIdDuringOrder/"
    
    static let GET_ALL_INVESTIGATIONS_GLOBAL = "\(base.BASE_URL)/investigation/getAllInvestigation"
    static let GET_INVESTIGATOIN_BY_NAME = "\(base.BASE_URL)/investigation/search/"
    static let BOOK_INVESTIGATION = "\(base.BASE_URL)/bookInvestigation/addBooking"
    static let GET_INVESTIGATION_INVOICE = "\(base.BASE_URL)/bookInvestigation/getInvestigationBookingsByOrgId/"
    static let ADD_INVESTIGATION = "\(base.BASE_URL)/investigation/addInvestigation"
    static let UPDATE_INVESTIGATION_BY_ID = "\(base.BASE_URL)/investigation/updateInvestigation/"
    static let GET_ORG_INVESTIGATION_LIST = "\(base.BASE_URL)/investigation//getAllInvestigationByOrg/"
    
    
    static let GET_BRAND_DRUG = "\(base.BASE_URL)/drugs/searchDrugByBrandName/"
    
    static let ADD_ORG_ADMIN = "\(base.BASE_URL)/org_admin/addOrgAdmin"
    static let GET_ORG_ADMIN = "\(base.BASE_URL)/org_admin/getOrgAdmins/"
    
    static let ADD_ADMIN = "\(base.BASE_URL)/admin/addAdmin"
    static let GET_ADMIN = "\(base.BASE_URL)/admin/getAdmins/"
    
    
    static let GET_PARMACY_INVOICE = "\(base.BASE_URL)/drugOrders/getAllDrugOrdersByOrgId/"
    static let CREATE_PHARMACY_INVOICE = "\(base.BASE_URL)/drugOrders/saveOrder"
    
    
    
    static let GET_DOCTOR_BY_ORG_SPT = "http://localhost:9191/doctors/getAllDoctors/"
    static let CREATE_DOCTOR_BY_ORG = "http://localhost:9191/doctors/addDoctor/"
    static let MAKE_APPOINTMENT = "http://localhost:9191/appointments/makeAppointment"
    static let GET_APPOINTMENT_INVOICE = "http://localhost:9191/appointments/getAppointmentsByOrg/"
    
    static let SEARCH_ORGANIZATION = "http://localhost:9191/organization/search/"
    
    static let GET_USER = "http://localhost:9191/users/"
    
    static let GET_PATIENT_BY_ORG = "http://localhost:9191/patient/search/"
    
    
    struct Hospitals{
        static let GETALLHOSPITAL = "http://localhost:9191/organization/Hospital"
    }
    
    struct Chamber{
        static let GETALLCHAMBER = "http://localhost:9191/organization/Chamber"
    }
    
    struct DiagnosticCenter{
        static let GETALLDC = "http://localhost:9191/organization/Diagnostic%20Center"
    }
    
    struct Pharmacy{
        static let GET_ALL_PHARMA = "http://localhost:9191/organization/Pharmacy"
    }
    
    struct OrgType {
        static let HOSPITAL = "Hospital"
        static let CHAMBER = "Chamber"
        static let DIAGNOSTIC_CENTER = "Diagnostic Center"
        static let PHARMACY = "Pharmacy"
    }
    
    struct Login{
        static let AUTHENTICATE = "http://localhost:9191/authenticate"
    }
    
    struct Role {
        static let ORG_ADMIN = "ROLE_ORG_ADMIN"
        static let NORMAL_ADMIN = "ROLE_ADMIN"
        static let ROOT = "ROLE_ROOT"
    }
    
}

struct base {
    static let BASE_URL = "http://localhost:9191"
}
