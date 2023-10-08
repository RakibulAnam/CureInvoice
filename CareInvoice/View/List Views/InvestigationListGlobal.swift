//
//  InvestigationListGlobal.swift
//  CareInvoice
//
//  Created by Jotno on 10/2/23.
//

import SwiftUI

struct InvestigationListGlobal: View {
    
    @StateObject var manager = OrganizationManager()
    
    @State private var isMenuOpen = false
    @State var investigationSearch = ""
    @AppStorage("ROLE") var userRole : String = ""
    @AppStorage("AuthToken") var AuthToken : String = ""
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                HStack() {
                    Image(systemName: "magnifyingglass.circle")
                    TextField("Search Investigation", text: $investigationSearch)
                        .onChange(of: investigationSearch) { newValue in
                            if newValue == ""{
                                manager.getAllInvestigation()
                            }else {
                                manager.getInvestigationByName(name: newValue)
                            }
                            
                        }

                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding(.horizontal, 20)
             
                
//                HStack{
//                    
//                    Text("Investigations")
//                        .font(.title)
//                    Spacer()
//               
//                    
//                }
//                .padding(.horizontal)
                
                
                List{
                    
                    if investigationSearch == "" {
                        ForEach(manager.investigationList){ item in
                            
                            NavigationLink {
                                AddInvestigationForm(profile: item)
                            } label: {
                                InvestigationCell(investigation: item)
                                    .onAppear{
                                        if(manager.investigationList.last?.id == item.id){
                                            manager.getAllInvestigation()
                                            print("paginated")
                                        }
                                    }
                            }

                            
                            
                            
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }else {
                        ForEach(manager.searchedInvestigationList){ item in
                            
                            NavigationLink {
                                AddInvestigationForm(profile: item)
                            } label: {
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
                        manager.page = -1
                        manager.investigationList.removeAll()
                        manager.getAllInvestigation()
                    }
                }
                .refreshable {
                    DispatchQueue.main.async {
                        manager.page = -1
                        manager.investigationList.removeAll()
                        manager.getAllInvestigation()
                    }
                }
            }//: VSTACK
            
            NavigationLink(destination: AddInvestigationForm()) {
                Image(systemName: "plus")
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(Color("PrimaryColor"))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4, x: 0, y: 4)
            }.padding() //: FLOATING BUTTON
            
            
        }//: ZSTACK
    }
}

struct InvestigationListGlobal_Previews: PreviewProvider {
    static var previews: some View {
        InvestigationListGlobal()
    }
}
