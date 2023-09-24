//
//  OrganizationModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/12/23.
//

import Foundation
import SwiftUI


struct OrganizationModel : Codable, Identifiable{
    
    var id: Int?
    let name : String
    let address : String
    let contact : String
    let type : String
    let email : String
    let emergencyContact : String
    let operatingHour : String
    var orgAdmin : [OrgAdminModel]?
    
    
}

