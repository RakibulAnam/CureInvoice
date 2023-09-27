//
//  InvoiceViewModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/25/23.
//

import Foundation

class InvoiceViewModel : ObservableObject {
    
    @Published var invoice : Invoice?
    
    
    func setInvoice(name : String, contact : String, selectedInvestigation : [Investigation], totalFee : Int){
        invoice =  Invoice(patientName: name, patientContact: contact, investigation: selectedInvestigation, totalFee: totalFee)
    }
    
    
}
