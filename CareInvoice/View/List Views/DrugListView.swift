//
//  DrugListView.swift
//  CareInvoice
//
//  Created by Jotno on 9/26/23.
//

import SwiftUI

struct DrugListView: View {
    
    @StateObject var manager = Pharmacymanager()
    
    var body: some View {
        
        VStack {
            Text("Drugs")
            
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
        }
        
    }
}

struct DrugListView_Previews: PreviewProvider {
    static var previews: some View {
        DrugListView()
    }
}
