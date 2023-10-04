//
//  PharmacyStaffView.swift
//  CareInvoice
//
//  Created by Jotno on 9/26/23.
//

import SwiftUI

struct PharmacyStaffView: View {
    
    @State private var isMenuOpen = false
    @State var drugSearch = ""
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
                    DrugListView()
                        .tabItem {
                            Image(systemName: "pill")
                            Text("Drugs")
                        }
                    
                    PharmacyInvoiceList()
                        .tabItem {
                            Image(systemName: "doc.text")
                            Text("Invoice")
                        }
                    
                    if userRole == K.Role.ORG_ADMIN{
                        PharmacyAdminListView()
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

struct PharmacyStaffView_Previews: PreviewProvider {
    static var previews: some View {
        PharmacyStaffView()
    }
}
