//
//  DrugListView.swift
//  CareInvoice
//
//  Created by Jotno on 9/26/23.
//

import SwiftUI

struct DrugListView: View {
    
    @StateObject var manager = Pharmacymanager()
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
                .padding(.horizontal, 20)
                
                HStack{
                    
                    Text("Drug List")
                        .font(.title)
                    Spacer()
                    NavigationLink(destination: DrugBillForm().navigationBarTitleDisplayMode(.inline)) {
                        Text("Make Bill")
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
                    ForEach(manager.drugList) { drug in
                        
                        NavigationLink {
                            DrugDetailView(drugModel: drug)
                        } label: {
                            DrugCell(drugModel: drug)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.plain)
                .navigationTitle("")
                .onAppear {
                    DispatchQueue.main.async {
                        manager.getAllDrugs()
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
