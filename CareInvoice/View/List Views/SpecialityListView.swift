//
//  SpecialityListView.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct SpecialityListView: View {
    
  //  @StateObject var manager = HospitalManager()
    
    @State var specilityList : [SpecialityListModel] = [
        SpecialityListModel(id: 1, medSpecName: "Skin & VD", iconUrl: "skin-cell.png"),
        SpecialityListModel(id: 2, medSpecName: "Hematology", iconUrl: "hematology.png"),
        SpecialityListModel(id: 3, medSpecName: "Physical Medicine", iconUrl: "physical-medicine.png"),
        SpecialityListModel(id: 4, medSpecName: "Rheumatology", iconUrl: "rheumatology.png")
    ]
    
    var body: some View {
        
        
        
        List{
            ForEach(specilityList) { list in
                
                NavigationLink {
                    SpecialityDetailView(id: list.id!)
                } label: {
                    SpecialityCell(model: list)
                }

                
                
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
        }
        .listStyle(.plain)
        .navigationTitle("")
        
        
    }
}

struct SpecialityListView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialityListView()
    }
}
