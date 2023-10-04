//
//  DiagnosticStaffView.swift
//  CareInvoice
//
//  Created by Jotno on 10/1/23.
//

import SwiftUI

struct DiagnosticStaffView: View {
    
    @State private var isMenuOpen = false
    @AppStorage("ROLE") var userRole : String = ""
    @AppStorage("AuthToken") var AuthToken : String = ""
    @AppStorage("UserId") var UserId : Int = 0
    
    var body: some View {
        NavigationView {
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
                        
                        VStack {
                            UserProfileView(userId: UserId)
                            
                            Button {
                                userRole = ""
                                AuthToken = ""
                            } label: {
                                
                                Text("Logout")
                                    .font(.title3)
                                    .padding()
                                    .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(lineWidth: 1)
                                        
                                    )
                            }
                        }
                        .padding()
                    }

                }
                .padding(.horizontal, 20)
                
                
                TabView {
                    InvestigationListView()
                        .tabItem {
                            Image(systemName: "bandage")
                            Text("Investigations")
                        }
                    
                    DiagnosticInvoiceList()
                        .tabItem {
                            Image(systemName: "doc.text")
                            Text("Invoice")
                        }
                    
                    if userRole == K.Role.ORG_ADMIN{
                        DiagnosticAdminListView()
                            .tabItem {
                                Image(systemName: "person.circle")
                                Text("Admins")
                            }
                    }
                  
                    
                }
                
                
                
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            
           
        }
    }
}

struct DiagnosticStaffView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosticStaffView()
    }
}
