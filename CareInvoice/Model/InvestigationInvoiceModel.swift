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
    let investigation : [InvestigationModel]
    let totalFee : Int
    
}
