//
//  InvestigationListView.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct InvestigationListView: View {
    
   
    @StateObject var manager = DiagnosticCenterManager()
    
    @State private var isMenuOpen = false
    @State var investigationSearch = ""
    @AppStorage("ROLE") var userRole : String = ""
    @AppStorage("AuthToken") var AuthToken : String = ""
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            VStack {
                HStack() {
                    Image(systemName: "magnifyingglass.circle")
                    TextField("Search Investigation", text: $investigationSearch)
                        .onChange(of: investigationSearch) { newValue in
                            if newValue == ""{
                                manager.getAllInvestigationByOrg(orgId: OrgID)
                            }else {
                                manager.getInvestigationByName(orgId: OrgID, name: newValue)
                            }

                        }

                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding(.horizontal, 20)
             
                
                HStack{
                    
                    Text("Investigations")
                        .font(.title)
                    Spacer()
                    /*
                    if userRole == K.Role.NORMAL_ADMIN{
                        NavigationLink(destination: DrugBillForm().navigationBarTitleDisplayMode(.inline)) {
                            Text("Book Investigation")
                                .padding(5)
                                .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke()
                                )
                                .foregroundColor(Color("PrimaryColor"))
                                
                        }
                    }
                    */
                    
                    NavigationLink(destination: BookInvestigationForm().navigationBarTitleDisplayMode(.inline)) {
                        Text("Book Investigation")
                            .padding(5)
                            .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke()
                            )
                            .foregroundColor(Color("PrimaryColor"))
                            
                    }
                    
                }
                .padding(.horizontal)
                
                
                List{
                    
//                    ForEach(manager.investigationList){ item in
//
//                        InvestigationCell(investigation: item)
//
//                    }
//                    .listRowSeparator(.hidden)
//                    .listRowInsets(EdgeInsets())
//
                    
                    if investigationSearch == "" {
                        ForEach(manager.investigationList){ item in
                            
                            if userRole == K.Role.ORG_ADMIN{
                                NavigationLink {
                                   OrgInvestigationEditForm(model: item)
                                } label: {
                                    InvestigationCell(investigation: item)
                                }
                            }
                            else {
                                InvestigationCell(investigation: item)
                            }
                         

                            
                          
                            
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }else {
                        ForEach(manager.searchedInvestigationList){ item in
                           
                            if userRole == K.Role.ORG_ADMIN{
                                NavigationLink {
                                   OrgInvestigationEditForm(model: item)
                                } label: {
                                    InvestigationCell(investigation: item)
                                }
                            }
                            else {
                                InvestigationCell(investigation: item)
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
                        manager.getAllInvestigationByOrg(orgId: OrgID)
                    }
                }
            }//: VSTACK
            
            
        }//: ZSTACK
        
        
    }
}

struct InvestigationListView_Previews: PreviewProvider {
    static var previews: some View {
        InvestigationListView()
    }
}
