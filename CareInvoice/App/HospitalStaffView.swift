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
                
                   
                    SpecialityListView()
                        .tabItem {
                            Image(systemName: "waveform.path.ecg")
                            Text("Specialities")
                        }
                       
                    
                    RevenueView()
                        .tabItem {
                            Image(systemName: "dollarsign")
                            Text("Revenue")
                        }
                    
                    
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
