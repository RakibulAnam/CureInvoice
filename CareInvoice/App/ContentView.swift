//
//  ContentView.swift
//  CareInvoice
//
//  Created by Jotno on 9/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("ROLE") var userRole : String = ""
    @AppStorage("AuthToken") var AuthToken : String = ""
    
    var body: some View {
        
        
        ZStack{
            
            if userRole.isEmpty {
                OnboardingView()
            } else if userRole == "ROLE_ROOT" {
                SuperAdminHomeView()
            } else if userRole == "ROLE_ORG_ADMIN"{
                Text("ORG ADMIN DASH")
            }
            
        }
        .onAppear{
            userRole = ""
        }
        
      
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
