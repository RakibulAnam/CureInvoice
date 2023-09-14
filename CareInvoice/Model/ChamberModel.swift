//
//  ChamberModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/13/23.
//

import Foundation


struct ChamberModel : Codable , Identifiable {
    
    var id: Int?
    let name : String
    let address : String
    let contact : String
    let type : String
    let email : String
    let emergencyContact : String
    let operatingHour : String
//    let admin : []
//    let department : []
//    let patients : []
//    let compounders : []
//    let medSpecialists : []
}
