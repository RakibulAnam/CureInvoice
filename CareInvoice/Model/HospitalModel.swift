//
//  HospitalModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/12/23.
//

import Foundation


/*
 
 "id": 1,
 "name": "Hospi",
 "address": "Something",
 "contact": "01677397270",
 "type": "Hospital",
 "email": "rohid@gmail.com",
 "emergencyContact": "01911362438",
 "operatingHour": "9 AM - 5 PM",
 "admin": [],
 "department": [],
 "patients": [],
 "compounders": [],
 "medSpecialists": []
 
 
 */


struct HospitalModel : Codable , Identifiable {
    
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
