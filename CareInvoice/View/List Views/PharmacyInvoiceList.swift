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
    @StateObject var orgManager = OrganizationManager()
    @State var invoiceSearch = ""
    
    var body: some View {
        
        
         VStack {
           

//             HStack{
//                 
//                 Text("Invoices")
//                     .font(.title)
//                 Spacer()
//             
//             }
//             .padding(.horizontal)
             
             
             HStack() {
                 Image(systemName: "magnifyingglass.circle")
                 TextField("Search Invoice", text: $invoiceSearch)
                     .textInputAutocapitalization(.never)
                     .autocorrectionDisabled(true)
                     .onChange(of: invoiceSearch) { newValue in
                         if newValue == ""{
                             manager.getAllInvoice(orgId: OrgID)
                         }else {
                             manager.searchInvoice(orgId: OrgID, name: newValue)
                         }
                         
                     }
             }
             .padding(.horizontal, 20)
             
             List {
                 
                 if invoiceSearch.isEmpty{
                     ForEach(manager.invoiceList) { item in
                         
                         if let orgModel = orgManager.orgModel {
                             NavigationLink(destination: DrugInvoiceView(invoice: item, orgModel: orgModel)) {
                                 InvoiceCell(model: item)
                                     .onAppear{
                                         if(manager.invoiceList.last?.id == item.id){
                                             manager.getAllInvoice(orgId: OrgID)
                                             print("paginated")
                                         }
                                     }
                             }
                         }
    
                     }
                     .listRowInsets(EdgeInsets())
                     .listRowSeparator(.hidden)
                 }else {
                     ForEach(manager.searchedinvoiceList, id:\.id) { item in
                         
                         
                         if let orgModel = orgManager.orgModel{
                             NavigationLink(destination: DrugInvoiceView(invoice: item, orgModel: orgModel)) {
                                 InvoiceCell(model: item)
                             }
                         }
             
                     }
                     .listRowInsets(EdgeInsets())
                     .listRowSeparator(.hidden)
                 }
                 
             }
             .listStyle(.plain)
             .refreshable {
                 manager.page = -1
                 manager.invoiceList.removeAll()
                 manager.getAllInvoice(orgId: OrgID)
             }
             .onAppear{
                 manager.page = -1
                 manager.invoiceList.removeAll()
                 manager.getAllInvoice(orgId: OrgID)
                 orgManager.getSingleOrganization(from: K.GET_ORGANIZATION_BY_ID, for: OrgID)
             }
         
             
         }//: VSTACK
         
        
        
    }
}

struct PharmacyInvoiceList_Previews: PreviewProvider {
    static var previews: some View {
        PharmacyInvoiceList()
    }
}
