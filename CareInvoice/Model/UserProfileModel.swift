//
//  UserProfileModel.swift
//  CareInvoice
//
//  Created by Jotno on 10/4/23.
//

import Foundation

struct UserProfileModel : Codable, Identifiable{
    
    
    var id: Int?
    let name : String
    let username : String
    let password : String?
    let email : String?
    let contact : String?
    var orgId : Int
    var roles : String
    var orgName : String
    
}
