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
        }
        .listStyle(.plain)
        .onAppear {
            DispatchQueue.main.async {
                manager.getSingleOrganization(from: K.GETORGANIZATIONBYID, for: org.id ?? 1)
            }
        }
        
        
        }
          
      

}

struct AdminListView_Previews: PreviewProvider {
    static var previews: some View {
        OrgAdminListView(org: OrganizationModel(name: "Ibne Sinha", address: "Dhaka", contact: "01677397270", type: "Hospital", email: "ibne@gmail.com", emergencyContact: "01911362438", operatingHour: "9 AM - 5 PM", orgAdmin: [OrgAdminModel(name: "Rohid", username: "roro", password: "123412", email: "a@b.com", contact: "0198827373")]))
    }
}
