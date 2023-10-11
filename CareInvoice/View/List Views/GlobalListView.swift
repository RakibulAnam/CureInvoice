//
//  GlobalListView.swift
//  CareInvoice
//
//  Created by Jotno on 10/11/23.
//

import SwiftUI

struct GlobalListView: View {
    var body: some View {
        
        NavigationView {
            List {
                NavigationLink(destination: DrugListGlobal()) {
                    HStack{
                        Image(systemName: "pill")
                            .foregroundColor(Color("PrimaryColor"))
                        Text("Drugs")
                    }
                    
                }
                NavigationLink(destination: InvestigationListGlobal()) {
                    HStack{
                        Image(systemName: "bandage")
                            .foregroundColor(Color("PrimaryColor"))
                        Text("Investigations")
                    }
                    
                }
                NavigationLink(destination: SpecialityListGlobal()) {
                    HStack{
                        Image(systemName: "allergens.fill")
                            .foregroundColor(Color("PrimaryColor"))
                        Text("Specialities")
                    }
                    
                }
            }
            .listRowSeparator(.hidden)
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
        }
        
        
    }
}

struct GlobalListView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalListView()
    }
}
