//
//  AdminModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import Foundation

struct AdminModel : Codable, Identifiable{
    
    
    var id: Int?
    let name : String
    let username : String
    let password : String?
    let email : String
    let contact : String
    
    
}
