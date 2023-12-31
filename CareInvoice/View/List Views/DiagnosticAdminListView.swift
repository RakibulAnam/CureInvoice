//
//  DiagnosticAdminListView.swift
//  CareInvoice
//
//  Created by Jotno on 10/2/23.
//

import SwiftUI

struct DiagnosticAdminListView: View {
    
    @StateObject var manager = DiagnosticCenterManager()
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 10) {
                
//                HStack{
//                    Spacer()
//
//                    NavigationLink(destination: EmptyView()) {
//                        Text("")                             }
//
//                }
//                .padding()
                
                List {
                    ForEach(manager.adminList) { admin in
                        NavigationLink(destination: AdminFormView(profile: admin)) {
                            CellView(model: admin)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }//: VSTACK
            .onAppear{
                manager.getAllAdmin(orgID: OrgID)
            }
            .refreshable {
                manager.getAllAdmin(orgID: OrgID)
            }
            
            NavigationLink(destination: AdminFormView().navigationBarTitleDisplayMode(.inline)) {
                Image(systemName: "plus")
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(Color("PrimaryColor"))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4, x: 0, y: 4)
            }.padding() //: FLOATING BUTTON
            
            
        }//: ZSTACK
    }
}

struct DiagnosticAdminListView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosticAdminListView()
    }
}
