//
//  InvoiceCell.swift
//  CareInvoice
//
//  Created by Jotno on 9/27/23.
//

import SwiftUI

struct InvoiceCell: View {
    
    var model : Any
    
    var body: some View {
        
        
        if let model = model as? DrugInvoiceModel{
            
            VStack {
                HStack(spacing: 20){
                    
                    Image(systemName: "doc.text")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .leading)
                    
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text(model.patientName)
                            .font(.title2)
                            .fontWeight(.regular)
                        
                        Text(model.patientContact)
                        
                        
                        
                    }
                    .font(.caption)
                    Spacer()
                    Text("Tk. \(Int(model.total))")
                        .font(.title2)
                    
                
                    
                    
                }
                .padding()
                
                Divider()
            }//:VSTACK
            
        }
        
        if let model = model as? InvestigationInvoiceModel{
            VStack {
                HStack(spacing: 20){
                    
                    Image(systemName: "doc.text")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .leading)
                    
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text(model.p_name)
                            .font(.title2)
                            .fontWeight(.regular)
                        
                        Text(model.contact)
                        
                        
                        
                    }
                    .font(.caption)
                    Spacer()
                    Text("Tk. \(Int(model.total))")
                        .font(.title2)
                    
                
                    
                    
                }
                .padding()
                
                Divider()
            }//:VSTACK
        }
        
        if let model = model as? AppointmentInvoiceModel{
            VStack {
                HStack(spacing: 20){
                    
                    Image(systemName: "doc.text")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .leading)
                    
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text(model.patientName)
                            .font(.title2)
                            .fontWeight(.regular)
                        
                        Text(model.patientContact)
                        
                        
                        
                    }
                    .font(.caption)
                    Spacer()
                    Text("Tk. \(Int(model.totalFees))")
                        .font(.title2)
                        .fontWeight(.regular)
                    
                
                    
                    
                }
                .padding()
                
                Divider()
            }//:VSTACK
        }
        
        
        
    }
}

struct InvoiceCell_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceCell(model: DrugInvoiceModel(patientName: "Rohid", patientContact: "01911362438", orgId: 1, drugList: [DrugModel(id: 1, brandName: "asd", price: 20.0, vendorName: "asdf", genericName: "asdas", formationName: "asd", strengthName: "asdas")], total: 220.0))
            .previewLayout(.sizeThatFits)
    }
    
}
