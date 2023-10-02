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
    var patientContact : String
    var docor : String
    var slot : String
    var ConsultationFee : String
    var Discount : String
    var total : Double
    
}
