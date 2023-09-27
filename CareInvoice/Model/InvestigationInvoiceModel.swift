//
//  investigationInvoiceModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/27/23.
//

import Foundation

struct InvestigationInvoiceModel {
    let patientName : String
    let patientContact : String
    let investigation : [Investigation]
    let totalFee : Int
    
}
