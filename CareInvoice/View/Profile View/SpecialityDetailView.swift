//
//  SpecialityDetailView.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct SpecialityDetailView: View {
    
    
    var id : Int
    @StateObject var manager = HospitalManager()
    
    var body: some View {
        
        TabView{
            
            
            DoctorListView(speciality: SpecialityListModel(id: 1, medSpecName: "SomeThing", iconUrl: "SomeTing"))
                .tabItem {
                    Image(systemName: "syringe")
                    Text("Doctors")
                }
            
//            InvestigationListView(speciality: SpecialityDetailModel(id: 1, doctor: [DoctorModel(id: 1, doctorName: "Nafis", doctorDegree: "MBBS"), DoctorModel(id: 2, doctorName: "Pritom", doctorDegree: "MBBS")], patients: [], services: [ServiceModel(id: 1, serviceName: "Dengue", serviceCharge: "5000"), ServiceModel(id: 2, serviceName: "Operation", serviceCharge: "10000")]))
//                .tabItem {
//                    Image(systemName: "brain.head.profile")
//                    Text("Investigations")
//                }
            
            AdminListView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Admins")
                }
            
            
            
        }
        
    }
}

struct SpecialityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialityDetailView(id: 1)
    }
}
