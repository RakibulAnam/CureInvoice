//
//  PharmacyInvoiceList.swift
//  CareInvoice
//
//  Created by Jotno on 9/27/23.
//

import SwiftUI

struct PharmacyInvoiceList: View {
    
    @AppStorage("OrgID") var OrgID : Int = 0
    @StateObject var manager = Pharmacymanager()
    
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
                     InvoiceCell(model: item)
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

struct PharmacyInvoiceList_Previews: PreviewProvider {
    static var previews: some View {
        PharmacyInvoiceList()
    }
}
