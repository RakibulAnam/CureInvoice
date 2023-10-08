//
//  DrugListView.swift
//  CareInvoice
//
//  Created by Jotno on 9/26/23.
//

import SwiftUI

struct DrugListView: View {
    
    @StateObject var manager = Pharmacymanager()
    @StateObject var orgManager = OrganizationManager()
    @State private var isMenuOpen = false
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
                        manager.getAllDrugs(orgID: OrgID)
                    }else {
                        manager.getDrugBrand(name: newValue)
                    }
                    
                }
                
                HStack{
                    
                    Text("Drug List")
                        .font(.title)
                    Spacer()
                    
                    if let orgModel = orgManager.orgModel{
                        NavigationLink(destination: DrugBillForm(orgModel: orgModel).navigationBarTitleDisplayMode(.inline)) {
                                Text("Make Bill")
                                    .padding(5)
                                    .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke()
                                    )
                                    .foregroundColor(Color("PrimaryColor"))
                                    
                            }
                    }
                    
                    
                    
                    
                    
                }
                .padding(.horizontal)
                
                
                List{
                    
                    if drugSearch == "" {
                        ForEach(manager.drugList) { drug in
                            
                            NavigationLink {
                                DrugDetailView(drugModel: drug)
                            } label: {
                                DrugCell(drugModel: drug)
                                    .onAppear{
                                        if(manager.drugList.last?.id == drug.id){
                                            manager.getAllDrugs(orgID: OrgID)
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
                    
//                    ForEach(manager.drugList) { drug in
//
//                        NavigationLink {
//                            DrugDetailView(drugModel: drug)
//                        } label: {
//                            DrugCell(drugModel: drug)
//                        }
//                    }
//                    .listRowSeparator(.hidden)
//                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.plain)
                .navigationTitle("")
                .refreshable {
                    DispatchQueue.main.async {
                        manager.page = -1
                        manager.drugList.removeAll()
                        manager.getAllDrugs(orgID: OrgID)
                    }
                }
                .onAppear {
                    DispatchQueue.main.async {
                        manager.page = -1
                        manager.drugList.removeAll()
                        manager.getAllDrugs(orgID: OrgID )
                        orgManager.getSingleOrganization(from: K.GET_ORGANIZATION_BY_ID, for: OrgID)
                    }
                }
            }//: VSTACK
            
            
        }//: ZSTACK
        
    }
}

struct DrugListView_Previews: PreviewProvider {
    static var previews: some View {
        DrugListView()
    }
}
