//
//  SuperAdminHomeView.swift
//  CareInvoice
//
//  Created by Jotno on 9/12/23.
//

import SwiftUI

struct SuperAdminHomeView: View {
    
    
    var body: some View {
        
        TabView {
            
            
            ListView(listURL: K.Hospitals.GETALLHOSPITAL, title: "Hospital", orgType: K.OrgType.HOSPITAL)
                .tabItem {
                    Image(systemName: "cross.case")
                    Text(K.OrgType.HOSPITAL)
                }
            
            ListView(listURL: K.Chamber.GETALLCHAMBER, title: "Chamber", orgType: K.OrgType.CHAMBER)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text(K.OrgType.CHAMBER)
                }
            
            ListView(listURL: K.DiagnosticCenter.GETALLDC, title: "Diagnostic Center", orgType: K.OrgType.DIAGNOSTIC_CENTER)
                .tabItem {
                    Image(systemName: "menucard")
                    Text(K.OrgType.DIAGNOSTIC_CENTER)
                }
            
            
        }//: TAB
        .toolbar(.hidden, for: .navigationBar)
        
        
    }
}

struct SuperAdminHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SuperAdminHomeView()
    }
}
