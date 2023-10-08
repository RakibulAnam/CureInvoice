//
//  SpecialityListGlobal.swift
//  CareInvoice
//
//  Created by Jotno on 10/3/23.
//

import SwiftUI

struct SpecialityListGlobal: View {
    
    @StateObject var manager = OrganizationManager()
    
    @State var specilityList : [SpecialityListModel] = [
        SpecialityListModel(id: 1, medSpecName: "Skin & VD", iconUrl: "skin-cell.png"),
        SpecialityListModel(id: 2, medSpecName: "Hematology", iconUrl: "hematology.png"),
        SpecialityListModel(id: 3, medSpecName: "Physical Medicine", iconUrl: "physical-medicine.png"),
        SpecialityListModel(id: 4, medSpecName: "Rheumatology", iconUrl: "rheumatology.png")
    ]
    @AppStorage("OrgID") var OrgID : Int = 0
    
    @State var specialitySearch = ""
    
    var body: some View {
        
        
        ZStack(alignment: .bottomTrailing) {
            
            VStack {
                
                HStack() {
                    Image(systemName: "magnifyingglass.circle")
                    TextField("Search Speciality", text: $specialitySearch)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .onChange(of: specialitySearch) { newValue in
                            if newValue == ""{
                                manager.getAllSepcialityGlobal()
                            }else {
                                manager.getSearchedSpeciality(name: newValue)
                            }
                            
                        }
                }
                .padding(.horizontal, 20)
                
                List{
                    if specialitySearch == "" {
                        ForEach(manager.specialityList) { list in
                            
                            NavigationLink {
                                AddSpecialityForm(profile: list)
                            } label: {
                                SpecialityCell(model: list)
                                    .onAppear{
                                        if(manager.specialityList.last?.id == list.id){
                                            manager.getAllGlobalDrugs()
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
                                AddSpecialityForm(profile: list)
                            } label: {
                                SpecialityCell(model: list)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }
                    
                    
                    
//                    ForEach(manager.specialityList) { list in
//                        
//                        NavigationLink {
//                            AddSpecialityForm(profile: list)
//                        } label: {
//                            SpecialityCell(model: list)
//                        }
//
//                        
//                        
//                    }
//                    .listRowSeparator(.hidden)
//                    .listRowInsets(EdgeInsets())
//                    .refreshable {
//                        manager.getAllSepcialityGlobal()
//                    }
                }
                .listStyle(.plain)
                .navigationTitle("")
                .onAppear {
                    DispatchQueue.main.async {
                        manager.page = -1
                        manager.specialityList.removeAll()
                        manager.getAllSepcialityGlobal()
                    }
                    
                }
                .refreshable {
                    DispatchQueue.main.async {
                        manager.page = -1
                        manager.specialityList.removeAll()
                        manager.getAllSepcialityGlobal()
                    }
                }
            }
            
            NavigationLink(destination: AddSpecialityForm()) {
                Image(systemName: "plus")
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(Color("PrimaryColor"))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4, x: 0, y: 4)
            }.padding() //: FLOATING BUTTON
            
            
        }
        
    
        
    }
}

struct SpecialityListGlobal_Previews: PreviewProvider {
    static var previews: some View {
        SpecialityListGlobal()
    }
}
