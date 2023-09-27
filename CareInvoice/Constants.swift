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
    
    static let GET_ALL_SPECIALITY = "http://localhost:9191/specialist/getAllSpecialist"
    
    static let GET_ALL_DRUGS = "http://localhost:9191/drugs/getAllDrugs"
    
    static let ADD_ORG_ADMIN = "http://localhost:9191/org_admin/addOrgAdmin/"
    static let GET_ORG_ADMIN = "http://localhost:9191/org_admin/getOrgAdmins/"
    
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
    
}
