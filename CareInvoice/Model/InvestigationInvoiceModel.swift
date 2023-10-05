//
//  investigationInvoiceModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/27/23.
//

import Foundation

struct InvestigationInvoiceModel : Codable, Identifiable {
    
    var id : Int?
    let p_name : String
    var pid : Int?
    let contact : String
    var org_id : Int
    let investigationList : [InvestigationModel]
    let total : Double
    
}
