//
//  AppointmentInvoiceModel.swift
//  CareInvoice
//
//  Created by Jotno on 10/2/23.
//

import Foundation

struct AppointmentInvoiceModel : Codable, Identifiable {
    var id : Int?
    var patientName : String
    var orgId : Int
    var patientContact : String
    var patientId : Int?
    var doc_name : String
    var doc_id : Int
    var slot : String
    var consultationFee : String
    var discount : String
    var totalFees : Double
    
}
