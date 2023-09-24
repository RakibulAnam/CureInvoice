//
//  SuperAdminHomeView.swift
//  CareInvoice
//
//  Created by Jotno on 9/12/23.
//

import SwiftUI

struct SuperAdminHomeView: View {
    
    @State private var isMenuOpen = false
    @AppStorage("ROLE") var userRole : String = ""
    @AppStorage("AuthToken") var AuthToken : String = ""
    var body: some View {
        
        ZStack {
            VStack {
                
                HStack() {
                    Spacer()
                    Button {
                        isMenuOpen.toggle()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .sheet(isPresented: $isMenuOpen) {
                        Button {
                            userRole = ""
                            AuthToken = ""
                        } label: {
                            Text("Logout")
                        }
                    }

                }
                .padding(.horizontal, 20)
                
                
                TabView {
                    
                    
                    OrgListView(listURL: K.Hospitals.GETALLHOSPITAL, title: "\(K.OrgType.HOSPITAL)s", orgType: K.OrgType.HOSPITAL)
                        .tabItem {
                            Image(systemName: "cross.case")
                            Text(K.OrgType.HOSPITAL)
                        }
                    
                    OrgListView(listURL: K.Chamber.GETALLCHAMBER, title: "\(K.OrgType.CHAMBER)s", orgType: K.OrgType.CHAMBER)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text(K.OrgType.CHAMBER)
                        }
                    
                    OrgListView(listURL: K.DiagnosticCenter.GETALLDC, title: "\(K.OrgType.DIAGNOSTIC_CENTER)s", orgType: K.OrgType.DIAGNOSTIC_CENTER)
                        .tabItem {
                            Image(systemName: "menucard")
                            Text(K.OrgType.DIAGNOSTIC_CENTER)
                        }
                    
                }//TABVIEW
              

            }//Vstack
            
         

        }//Zastack
        
        
        
    }
}

struct SuperAdminHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SuperAdminHomeView()
    }
}
