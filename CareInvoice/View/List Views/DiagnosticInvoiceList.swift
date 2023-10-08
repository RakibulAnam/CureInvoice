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
    @StateObject var orgManager = OrganizationManager()
    
    var body: some View {
        VStack {
          
//            HStack{
//                Text("Invoices")
//                    .font(.title)
//                Spacer()
//            
//            }
//            .padding(.horizontal)
            
            List {
                ForEach(manager.invoiceList) { item in
                    
                    if let orgModel = orgManager.orgModel {
                        NavigationLink(destination: InvestigationInvoiceView(invoice: item, orgModel: orgModel)) {
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

struct DiagnosticInvoiceList_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosticInvoiceList()
    }
}
