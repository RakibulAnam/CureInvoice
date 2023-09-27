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
    
    var body: some View {
        NavigationView {
            
            
            VStack {
                
                HStack() {
                    Image(systemName: "pill")
                    TextField("Search Drugs", text: $drugSearch)
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
                
                
                DrugListView()
            }
            
           
        }
    }
}

struct PharmacyStaffView_Previews: PreviewProvider {
    static var previews: some View {
        PharmacyStaffView()
    }
}
