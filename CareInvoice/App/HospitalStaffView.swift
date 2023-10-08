//
//  HospitalStaffView.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct HospitalStaffView: View {
    
    
    @State private var isMenuOpen = false
    @AppStorage("ROLE") var userRole : String = ""
    @AppStorage("AuthToken") var AuthToken : String = ""
    @AppStorage("UserId") var UserId : Int = 0
    @AppStorage("isLoggedIn") var isLoggedIn : Bool = false
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
                                isLoggedIn = false
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
                
                   
                    SpecialityListView()
                        .tabItem {
                            Image(systemName: "waveform.path.ecg")
                            Text("Specialities")
                        }
                       
                    AppointmentInvoiceList()
                        .tabItem {
                            Image(systemName: "doc.text")
                            Text("Invoice")
                        }
                    
                    if userRole == K.Role.ORG_ADMIN{
                        HospitalAdminList()
                            .tabItem {
                                Image(systemName: "person.circle")
                                Text("Admins")
                            }
                    }
                    
//                    RevenueView()
//                        .tabItem {
//                            Image(systemName: "dollarsign")
//                            Text("Revenue")
//                        }
                    
                    
                }
                .navigationTitle("")
            }//:VSTACK
            
            
            
            
           
        }
    }
}

struct HospitalStaffView_Previews: PreviewProvider {
    static var previews: some View {
        HospitalStaffView()
    }
}
