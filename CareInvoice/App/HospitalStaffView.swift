//
//  HospitalStaffView.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct HospitalStaffView: View {
    var body: some View {
        NavigationView {
            
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
            
            
            
            
            Text("Hello")
        }
    }
}

struct HospitalStaffView_Previews: PreviewProvider {
    static var previews: some View {
        HospitalStaffView()
    }
}
