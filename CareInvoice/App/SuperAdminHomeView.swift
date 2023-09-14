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
            
            
            ListView(listURL: K.Hospitals.GETALLHOSPITAL, title: "\(K.OrgType.HOSPITAL)s", orgType: K.OrgType.HOSPITAL)
                .tabItem {
                    Image(systemName: "cross.case")
                    Text(K.OrgType.HOSPITAL)
                }
            
            ListView(listURL: K.Chamber.GETALLCHAMBER, title: "\(K.OrgType.CHAMBER)s", orgType: K.OrgType.CHAMBER)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text(K.OrgType.CHAMBER)
                }
            
            ListView(listURL: K.DiagnosticCenter.GETALLDC, title: "\(K.OrgType.DIAGNOSTIC_CENTER)s", orgType: K.OrgType.DIAGNOSTIC_CENTER)
                .tabItem {
                    Image(systemName: "menucard")
                    Text(K.OrgType.DIAGNOSTIC_CENTER)
                }
            
            
        }//: TAB
        
        
        
    }
}

struct SuperAdminHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SuperAdminHomeView()
    }
}
