//
//  SpecialityDetailView.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct SpecialityDetailView: View {
    
    
    var id : Int
    
    var body: some View {
        
        TabView{
            
            
            DoctorListView(speciality: SpecialityDetailModel(id: 1, doctor: [DoctorModel(id: 1, doctorName: "Nafis", doctorDegree: "MBBS"), DoctorModel(id: 2, doctorName: "Pritom", doctorDegree: "MBBS")], patients: [], services: []))
                .tabItem {
                    Image(systemName: "syringe")
                    Text("Doctors")
                }
            
            InvestigationListView(speciality: SpecialityDetailModel(id: 1, doctor: [DoctorModel(id: 1, doctorName: "Nafis", doctorDegree: "MBBS"), DoctorModel(id: 2, doctorName: "Pritom", doctorDegree: "MBBS")], patients: [], services: [ServiceModel(id: 1, serviceName: "Dengue", serviceCharge: "5000"), ServiceModel(id: 2, serviceName: "Operation", serviceCharge: "10000")]))
                .tabItem {
                    Image(systemName: "brain.head.profile")
                    Text("Investigations")
                }
            
            
            
        }
        
    }
}

struct SpecialityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialityDetailView(id: 1)
    }
}
