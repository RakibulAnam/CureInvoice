//
//  Constants.swift
//  CareInvoice
//
//  Created by Jotno on 9/12/23.
//

import Foundation


struct K{
    
    static let CREATE_ORGANIZATION = "http://localhost:9191/organization/create"
    static let UPDATE_ORGANIZATION = "http://localhost:9191/organization/updateOrganizationProfile/"
    static let GET_ORGANIZATION_BY_ID = "http://localhost:9191/organization/getOrganizationById/"
    static let GET_ROLE = "http://localhost:9191/getRole"
    
    static let GET_ALL_SPECIALITY_GLOBAL = "http://localhost:9191/specialist/getAllSpecialist"
    static let GET_ALL_SPECIALITY_BY_ORG = "http://localhost:9191/specialist/getAllSpecialist"
    
    static let GET_ALL_DRUGS_BY_ORG = "http://localhost:9191/drugs/getAllDrugs/"
    static let GET_ALL_DRUGS_GLOBAL = "http://localhost:9191/drugs/getAllDrugs"
    static let CREATE_DRUG = "http://localhost:9191/drugs/addDrug"
    static let UPDATE_DRUG = "http://localhost:9191/drugs/updateDrug/"
    
    static let GET_ALL_INVESTIGATIONS = "http://localhost:9191/investigation/getAllInvestigation"
    static let GET_INVESTIGATOIN_BY_NAME = "http://localhost:9191/investigation/search/"
    static let BOOK_INVESTIGATION = "http://localhost:9191/bookInvestigation/addBooking"
    static let GET_INVESTIGATION_INVOICE = "http://localhost:9191/bookInvestigation/getInvestigationBookingsByOrgId/"
    
    static let GET_BRAND_DRUG = "http://localhost:9191/drugs/searchDrugByBrandName/"
    
    static let ADD_ORG_ADMIN = "http://localhost:9191/org_admin/addOrgAdmin"
    static let GET_ORG_ADMIN = "http://localhost:9191/org_admin/getOrgAdmins/"
    
    static let ADD_ADMIN = "http://localhost:9191/admin/addAdmin"
    static let GET_ADMIN = "http://localhost:9191/admin/getAdmins/"
    
    
    static let GET_PARMACY_INVOICE = "http://localhost:9191/drugOrders/getAllDrugOrdersByOrgId/"
    static let CREATE_PHARMACY_INVOICE = "http://localhost:9191/drugOrders/saveOrder"
    
    
    
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
    }
    
}
