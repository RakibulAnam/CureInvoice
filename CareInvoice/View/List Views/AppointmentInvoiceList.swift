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
    @StateObject var orgManager = OrganizationManager()
    @State var invoiceSearch = ""
    
    var body: some View {
        VStack {
          

//            HStack{
//                
//                Text("Invoices")
//                    .font(.title)
//                Spacer()
//            
//            }
//            .padding(.horizontal)
            
            
            
            
            
            List {
                ForEach(manager.invoiceList) { item in
                    
                    
                    if let orgModel = orgManager.orgModel{
                        NavigationLink(destination: AppointmentInvoiceView(invoice: item, orgModel: orgModel)) {
                            InvoiceCell(model: item)
                                .onAppear{
                                    if(manager.invoiceList.last?.id == item.id){
                                        manager.getInvoice(orgId: OrgID)
                                        print("paginated")
                                    }
                                }
                        }
                    }
                    
                
                    
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .onAppear{
                manager.page = -1
                manager.invoiceList.removeAll()
                manager.getInvoice(orgId: OrgID)
                orgManager.getSingleOrganization(from: K.GET_ORGANIZATION_BY_ID, for: OrgID)
            }
        
            
        }//: VSTACK
    }
}

struct AppointmentInvoiceList_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentInvoiceList()
    }
}
