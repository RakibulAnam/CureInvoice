//
//  DrugListGlobal.swift
//  CareInvoice
//
//  Created by Jotno on 10/2/23.
//

import SwiftUI

struct DrugListGlobal: View {
    
    @StateObject var manager = OrganizationManager()
    @State var drugSearch = ""
    @AppStorage("ROLE") var userRole : String = ""
    @AppStorage("AuthToken") var AuthToken : String = ""
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var body: some View {
        
        
        ZStack(alignment: .bottomTrailing) {
            VStack {
                HStack() {
                    Image(systemName: "magnifyingglass.circle")
                    TextField("Search Drugs", text: $drugSearch)
                    
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding(.horizontal, 20)
                .onChange(of: drugSearch) { newValue in
                    if newValue == ""{
                        manager.getAllGlobalDrugs()
                    }else {
                        manager.getDrugBrand(name: newValue)
                    }
                    
                }
                
//                    HStack{
//
//                        Text("Drug List")
//                            .font(.title)
//                        Spacer()
//                    }
//                    .padding(.horizontal)
                
                
                List{
                    
                    if drugSearch == "" {
                        ForEach(manager.drugList) { drug in
                            
                            NavigationLink {
                                DrugDetailView(drugModel: drug)
                            } label: {
                                DrugCell(drugModel: drug)
                                    .onAppear{
                                        if(manager.drugList.last?.id == drug.id){
                                            manager.getAllGlobalDrugs()
                                            print("paginated")
                                        }
                                    }
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }else {
                        ForEach(manager.searchedDrugList) { drug in
                            
                            NavigationLink {
                                DrugDetailView(drugModel: drug)
                            } label: {
                                DrugCell(drugModel: drug)
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
                        manager.drugList.removeAll()
                        manager.getAllGlobalDrugs()
                    }
                }
                .refreshable {
                    DispatchQueue.main.async {
                        manager.page = -1
                        manager.drugList.removeAll()
                        manager.getAllGlobalDrugs()
                    }
                }
                // LIST
                
             
                
            }//: VSTACK
            
            NavigationLink(destination: AddDrugForm()) {
                Image(systemName: "plus")
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(Color("PrimaryColor"))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4, x: 0, y: 4)
            }.padding() //: FLOATING BUTTON
            
        }
        
        /*
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    HStack() {
                        Image(systemName: "magnifyingglass.circle")
                        TextField("Search Drugs", text: $drugSearch)
                        
                    }
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .padding(.horizontal, 20)
                    .onChange(of: drugSearch) { newValue in
                        if newValue == ""{
                            manager.getAllGlobalDrugs()
                        }else {
                            manager.getDrugBrand(name: newValue)
                        }
                        
                    }
                    
//                    HStack{
//                        
//                        Text("Drug List")
//                            .font(.title)
//                        Spacer()
//                    }
//                    .padding(.horizontal)
                    
                    
                    List{
                        
                        if drugSearch == "" {
                            ForEach(manager.drugList) { drug in
                                
                                NavigationLink {
                                    DrugDetailView(drugModel: drug)
                                } label: {
                                    DrugCell(drugModel: drug)
                                        .onAppear{
                                            if(manager.drugList.last?.id == drug.id){
                                                manager.getAllGlobalDrugs()
                                                print("paginated")
                                            }
                                        }
                                }
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                        }else {
                            ForEach(manager.searchedDrugList) { drug in
                                
                                NavigationLink {
                                    DrugDetailView(drugModel: drug)
                                } label: {
                                    DrugCell(drugModel: drug)
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
                            manager.drugList.removeAll()
                            manager.getAllGlobalDrugs()
                        }
                    }
                    .refreshable {
                        DispatchQueue.main.async {
                            manager.page = -1
                            manager.drugList.removeAll()
                            manager.getAllGlobalDrugs()
                        }
                    }
                    // LIST
                    
                 
                    
                }//: VSTACK
                
                NavigationLink(destination: AddDrugForm()) {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color("PrimaryColor"))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                }.padding() //: FLOATING BUTTON
                
            }
        }//NAVIGATION VIEW
         */
    }
}
struct DrugListGlobal_Previews: PreviewProvider {
    static var previews: some View {
        DrugListGlobal()
    }
}
