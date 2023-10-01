//
//  InvestigationModel.swift
//  CareInvoice
//
//  Created by Jotno on 10/1/23.
//

import Foundation


struct InvestigationModel : Codable, Identifiable{
    var id : Int?
    let serviceName : String
    let serviceCharge : Double
}
