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
                    HStack(spacing: 20){
                        Image(systemName: "pills.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60, alignment: .center)
                            .foregroundColor(Color("PrimaryColor"))
                        
                        Text("Drugs")
                            .font(.title2)
                    }
                    
                }
                NavigationLink(destination: InvestigationListGlobal()) {
                    HStack(spacing: 20){
                        Image(systemName: "ivfluid.bag")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60, alignment: .center)
                            .foregroundColor(Color("PrimaryColor"))
                            
                        Text("Investigations")
                            .font(.title2)
                    }
                    
                }
                NavigationLink(destination: SpecialityListGlobal()) {
                    HStack(spacing: 20){
                        Image(systemName: "allergens.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60, alignment: .center)
                            .foregroundColor(Color("PrimaryColor"))
                        Text("Specialities")
                            .font(.title2)
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
