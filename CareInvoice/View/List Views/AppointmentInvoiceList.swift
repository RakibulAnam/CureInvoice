//
//  AppointmentInvoiceList.swift
//  CareInvoice
//
//  Created by Jotno on 10/3/23.
//

import SwiftUI

struct AppointmentInvoiceList: View {
    
    @AppStorage("OrgID") var OrgID : Int = 0
    @StateObject var manager = HospitalManager()
    
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
                    
                    NavigationLink(destination: AppointmentInvoiceView(invoice: item)) {
                        InvoiceCell(model: item)
                    }
                    
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .onAppear{
                manager.getInvoice(orgId: OrgID)
            }
        
            
        }//: VSTACK
    }
}

struct AppointmentInvoiceList_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentInvoiceList()
    }
}
