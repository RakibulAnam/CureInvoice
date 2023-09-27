//
//  InvoiceViewModel.swift
//  CareInvoice
//
//  Created by Jotno on 9/25/23.
//

import Foundation

class InvoiceViewModel : ObservableObject {
    
    @Published var invoice : InvestigationInvoiceModel?
    
    
    func setInvoice(name : String, contact : String, selectedInvestigation : [Investigation], totalFee : Int){
        invoice =  InvestigationInvoiceModel(patientName: name, patientContact: contact, investigation: selectedInvestigation, totalFee: totalFee)
    }
    
    
}
