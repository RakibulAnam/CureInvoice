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
            
//            NavigationView {
//                HospitalListView()
//                    .toolbar(.hidden, for: .navigationBar)
//            }
//            .tabItem {
//                Image(systemName: "house.fill")
//                Text("Hospital")
//            }
//
//            NavigationView {
//                ChamberListView()
//                    .toolbar(.hidden)
//            }
//            .tabItem {
//                Image(systemName: "arrow.up")
//                Text("Chamber")
//            }
            
            ListView(listURL: K.Hospitals.GETALLHOSPITAL, title: "Hospital", orgType: K.OrgType.HOSPITAL)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Hospital")
                }
            
            ListView(listURL: K.Chamber.GETALLCHAMBER, title: "Chamber", orgType: K.OrgType.CHAMBER)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Chamber")
                }
            
            
        }//: TAB
        .navigationBarBackButtonHidden(true)
        
    }
}

struct SuperAdminHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SuperAdminHomeView()
    }
}
