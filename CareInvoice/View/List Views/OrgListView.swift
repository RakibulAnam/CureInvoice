//
//  ListView.swift
//  CareInvoice
//
//  Created by Jotno on 9/14/23.
//

import SwiftUI

struct OrgListView: View {
    
    @StateObject private var manager = OrganizationManager()
    let listURL : String
    let title : String
    let orgType : String
    @AppStorage("ROLE") var userRole : String = ""
    @AppStorage("AuthToken") var AuthToken : String = ""
    
    var body: some View {
        
        
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                
                List{
                    ForEach(manager.organization) { organization in
                        NavigationLink(destination: OrganizationDetailView(org: organization, listUrl: listURL).navigationBarTitleDisplayMode(.inline)) {
                            CellView(model: organization)
                            
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .listSectionSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(title)
                //: LIST
                
                NavigationLink(destination: OrganizationFormView(manager: manager, orgType: orgType).navigationBarTitleDisplayMode(.inline)) {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color("PrimaryColor"))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                }.padding() //: FLOATING BUTTON
                
            }//: ZSTACK
            .onAppear {
                DispatchQueue.main.async {
                    manager.getOrganizationDetails(from: listURL)
                }
                
            }
        } //: NAVIGATION END
    }
}

struct ListView_Previews: PreviewProvider {
    
    static var previews: some View {
        OrgListView(listURL: K.Hospitals.GETALLHOSPITAL, title: "Hospital", orgType: K.OrgType.HOSPITAL)
    }
}
