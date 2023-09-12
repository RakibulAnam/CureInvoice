//
//  SuperAdminHomeView.swift
//  CareInvoice
//
//  Created by Jotno on 9/12/23.
//

import SwiftUI

struct SuperAdminHomeView: View {
    
    @StateObject private var hospitalManager = HospitalManager()
    
    
    var body: some View {
        
        ZStack {
            List{
                ForEach(hospitalManager.hospitals) { hospital in
                    Text(hospital.name)
                }
            }
        }//: ZSTACK
        .onAppear {
            hospitalManager.getHospitalDetails()
        }
        
        
        
    }
}

struct SuperAdminHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SuperAdminHomeView()
    }
}
