//
//  investigationInvoiceModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/27/23.
//

import Foundation

struct InvestigationInvoiceModel : Codable, Identifiable {
    var id : Int?
    let patientName : String
    let patientContact : String
    var orgId : Int
    let investigation : [InvestigationModel]
    let totalFee : Int
    
}
