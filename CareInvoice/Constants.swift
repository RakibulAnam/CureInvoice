//
//  Constants.swift
//  CareInvoice
//
//  Created by Jotno on 9/12/23.
//

import Foundation


struct K{
    
    static let CREATEORGANIZATION = "http://localhost:9191/organization/create"
    static let UPDATEORGANIZATION = "http://localhost:9191/organization/updateOrganizationProfile/"
    static let GETORGANIZATIONBYID = "http://localhost:9191/organization/getOrganizationById/"
    
    struct Hospitals{
        static let GETALLHOSPITAL = "http://localhost:9191/organization/Hospital"
    }
    
    struct Chamber{
        static let GETALLCHAMBER = "http://localhost:9191/organization/Chamber"
    }
    
    struct DiagnosticCenter{
        static let GETALLDC = "http://localhost:9191/organization/Diagnostic%20Center"
    }
    
    struct OrgType {
        static let HOSPITAL = "Hospital"
        static let CHAMBER = "Chamber"
        static let DIAGNOSTIC_CENTER = "Diagnostic Center"
    }
    
    struct Login{
        static let AUTHENTICATE = "http://localhost:9191/authenticate"
    }
    
}
