//
//  AdminListView.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct AdminListView: View {
    
    var admins  = [AdminModel(name: "Turjo", username: "TJ1", password: "123456", email: "tj@gmail.com", contact: "01911362438"),
                   AdminModel(name: "Adi", username: "AD1", password: "123456", email: "ad@gmail.com", contact: "01911362438")]
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 10) {
                
                HStack{
                    Spacer()
                    
                    NavigationLink(destination: EmptyView()) {
                        Text("")                             }
                    
                }
                .padding()
                
                List {
                    ForEach(admins) { admin in
                        CellView(model: admin)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }//: VSTACK
            
            NavigationLink(destination: AdminFormView().navigationBarTitleDisplayMode(.inline)) {
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

struct AdminListView_Previews: PreviewProvider {
    static var previews: some View {
        AdminListView()
    }
}
