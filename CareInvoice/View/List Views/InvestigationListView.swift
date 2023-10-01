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
    @State var drugSearch = ""
    @AppStorage("ROLE") var userRole : String = ""
    @AppStorage("AuthToken") var AuthToken : String = ""
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            VStack {
                HStack() {
                    Image(systemName: "pill")
                    TextField("Search Drugs", text: $drugSearch)

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
                    
                    ForEach(manager.investigationList){ item in
                        
                        InvestigationCell(investigation: item)
                        
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    
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
                .onAppear {
                    DispatchQueue.main.async {
                        manager.getAllInvestigation()
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
