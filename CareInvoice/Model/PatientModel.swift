//
//  PatientModel.swift
//  CareInvoice
//
//  Created by Jotno on 10/4/23.
//

import Foundation


struct PatientModel : Codable, Identifiable {
    
    
    /*
     
     "id": 7,
         "name": "Kajol",
         "contact": "01922323233",
         "since": null,
         "orgId": 29
     
     */
    
    var id : Int?
    var name : String
    var contact : String
    var orgId : Int
    
    
    
}
