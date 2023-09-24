//
//  SideMenuView.swift
//  CareInvoice
//
//  Created by Jotno on 9/20/23.
//

import SwiftUI


struct SideMenuView: View {
    
    @AppStorage("ROLE") var userRole : String = ""
    @AppStorage("AuthToken") var AuthToken : String = ""
    
    var body: some View {
        VStack {
            Button {
                userRole = ""
                AuthToken = ""
            } label: {
                Text("Logout")
            }
            .offset(y: 100)
            Spacer()
        }
        .frame(width: 200, height: .infinity)
        .background(Color(.blue))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
