//
//  DiagnosticInvoiceList.swift
//  CareInvoice
//
//  Created by Jotno on 10/2/23.
//

import SwiftUI

struct DiagnosticInvoiceList: View {
    
    @AppStorage("OrgID") var OrgID : Int = 0
    @StateObject var manager = DiagnosticCenterManager()
    
    var body: some View {
        VStack {
          
            HStack{
                Text("Invoices")
                    .font(.title)
                Spacer()
            
            }
            .padding(.horizontal)
            
            List {
                ForEach(manager.invoiceList) { item in
                    
                    NavigationLink(destination: InvestigationInvoiceView(invoice: item)) {
                        InvoiceCell(model: item)
                    }
                    
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .onAppear{
                manager.getAllInvoice(orgId: OrgID)
            }
        
            
        }//: VSTACK
    }
}

struct DiagnosticInvoiceList_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosticInvoiceList()
    }
}
