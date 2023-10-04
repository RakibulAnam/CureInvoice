//
//  SpecialityListView.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct SpecialityListView: View {
    
    @StateObject var manager = HospitalManager()
    
    @State var specilityList : [SpecialityListModel] = [
        SpecialityListModel(id: 1, medSpecName: "Skin & VD", iconUrl: "skin-cell.png"),
        SpecialityListModel(id: 2, medSpecName: "Hematology", iconUrl: "hematology.png"),
        SpecialityListModel(id: 3, medSpecName: "Physical Medicine", iconUrl: "physical-medicine.png"),
        SpecialityListModel(id: 4, medSpecName: "Rheumatology", iconUrl: "rheumatology.png")
    ]
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var body: some View {
        
        
        
        List{
            ForEach(manager.specialities) { list in
                
                NavigationLink {
                    DoctorListView(speciality: list)
                } label: {
                    SpecialityCell(model: list)
                }

                
                
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
        }
        .listStyle(.plain)
        .navigationTitle("")
        .onAppear {
            DispatchQueue.main.async {
                manager.getAllSepcialityByOrg(orgID: OrgID)
            }
            
        }
        
    }
}

struct SpecialityListView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialityListView()
    }
}
