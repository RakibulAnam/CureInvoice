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
    @AppStorage("OrgType") var OrgType : String = ""
    
    var body: some View {
        
        
        ZStack{
            
            if userRole.isEmpty {
                OnboardingView()
            } else if userRole == "ROLE_ROOT" {
                SuperAdminHomeView()
            } else if OrgType == K.OrgType.HOSPITAL{
                HospitalStaffView()
            }
            else if OrgType == K.OrgType.DIAGNOSTIC_CENTER{
                Text("Diagnostic")
            }
            else if OrgType == K.OrgType.CHAMBER{
                Text("Chamber")
            }
            else if OrgType == K.OrgType.PHARMACY{
                Text("Pharmacy")
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
