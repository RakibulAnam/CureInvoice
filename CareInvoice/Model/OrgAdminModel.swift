//
//  OrgAdminModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/17/23.
//

import Foundation


struct OrgAdminModel : Codable, Identifiable{
    
    
    var id: Int?
    let name : String
    let username : String
    let password : String?
    let email : String
    let contact : String
    
    
    
}
