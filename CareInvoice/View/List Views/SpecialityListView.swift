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
    @State var specialitySearch = ""
    
    var body: some View {
        
        
        VStack{
            
            HStack() {
                Image(systemName: "magnifyingglass.circle")
                TextField("Search Speciality", text: $specialitySearch)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .onChange(of: specialitySearch) { newValue in
                        if newValue == ""{
                            manager.getAllSepcialityByOrg(orgID: OrgID)
                        }else {
                            manager.getSearchedSpeciality(name: newValue)
                        }
                        
                    }
            }
            .padding(.horizontal, 20)
            
            List{
                
                if specialitySearch.isEmpty {
                    
                    ForEach(manager.specialities) { list in
                        
                        NavigationLink {
                            DoctorListView(speciality: list)
                        } label: {
                            SpecialityCell(model: list)
                                .onAppear{
                                    if(manager.specialities.last?.id == list.id){
                                        manager.getAllSepcialityByOrg(orgID: OrgID)
                                        print("paginated")
                                    }
                                }
                        }

                        
                        
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    
                }else {
                    ForEach(manager.searchedSpecialityList) { list in
                        
                        NavigationLink {
                            DoctorListView(speciality: list)
                        } label: {
                            SpecialityCell(model: list)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                }
                
                
            }
            .listStyle(.plain)
            .navigationTitle("")
            .onAppear {
                DispatchQueue.main.async {
                    manager.page = -1
                    manager.specialities.removeAll()
                    manager.getAllSepcialityByOrg(orgID: OrgID)
                }
                
            }
        }
      
        
    }
}

struct SpecialityListView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialityListView()
    }
}
