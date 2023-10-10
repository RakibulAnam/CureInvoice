//
//  AdminListView.swift
//  CareInvoice
//
//  Created by Jotno on 9/19/23.
//

import SwiftUI

struct OrgAdminListView: View {
    
    @State var org : OrganizationModel 
    @StateObject var manager = OrganizationManager()
    
    
    var body: some View {
       
        VStack(alignment: .leading){
            
            /*
            List{
                
                if let nOrg = manager.orgModel{
                    if let adminArray = nOrg.orgAdmin{
                        
                        ForEach(adminArray) { admin in
                                CellView(model: admin)
                                .listRowInsets(EdgeInsets())
                        }
                        .listSectionSeparator(.hidden)
                        .listRowSeparator(.hidden)
                        
                    }
                    }
                }
                
            //: LIST
             */
            
            
            List{
                ForEach(manager.orgAdmin) { admin in
                    NavigationLink(destination: UpdateOrgAdminForm(model: admin)) {
                        CellView(model: admin)
                    }
                
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .refreshable {
                DispatchQueue.main.async {
                    manager.getOrgAdmin(orgID: org.id!)
                }
            }
            
            
        }
        .listStyle(.plain)
        .onAppear {
            DispatchQueue.main.async {
                manager.getOrgAdmin(orgID: org.id!)
            }
        }
        
        
        }
          
      

}

struct OrgAdminListView_Previews: PreviewProvider {
    static var previews: some View {
        OrgAdminListView(org: OrganizationModel(id: 1, name: "Ibne Sinha", address: "Dhaka", contact: "01677397270", type: "Hospital", email: "ibne@gmail.com", emergencyContact: "01911362438", operatingHour: "9 AM - 5 PM", orgCode: "KHR"))
    }
}
