//
//  DrugInvoiceModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/27/23.
//

import Foundation

struct DrugInvoiceModel : Codable, Identifiable {
    var id : Int?
    var patientName : String
    var patientContact : String
    var orgId : Int
    var drugList : [DrugModel]
    var total : Double
    
}
