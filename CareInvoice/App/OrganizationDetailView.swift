//
//  OrganizationDetailView.swift
//  CareInvoice
//
//  Created by Jotno on 9/13/23.
//

import SwiftUI

struct OrganizationDetailView: View {
    
    //MARK: - PROPERTIES
    
    @State var org : OrganizationModel
    @StateObject private var manager = OrganizationManager()
    
    //MARK: - BODY
    var body: some View {
        
        NavigationView {
            ZStack(alignment: .bottomTrailing){
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("\(org.name)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                    
                        
                        VStack(alignment: .leading, spacing: 10){
                            Text("Address: \(org.address)")
                            
                            Text("Contact: \(org.contact)")
                            
                            Text("Email: \(org.email)")
                            
                            Text("Operating Hour: \(org.operatingHour)")
                        }
                        
                        
                       
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .edgesIgnoringSafeArea(.all)
                    .background(
                    Color("CardBackground")
                    )
                    .cornerRadius(20)
                .padding()
                    //: Card
                    
                    Text("Admins")
                        .padding()
                        .font(.largeTitle)
                    
                    Spacer()
                }// VSTACK
                
                NavigationLink(destination: OrganizationFormView(manager: manager, profile: org, orgType: org.type)) {
                    Image(systemName: "pencil")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color("PrimaryColor"))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                }.padding() //: FLOATING BUTTON
            }//: ZSTACK
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        

    }
}

struct OrganizationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationDetailView(org: OrganizationModel(name: "Ibne Sinha", address: "Dhaka", contact: "01677397270", type: "Hospital", email: "ibne@gmail.com", emergencyContact: "01911362438", operatingHour: "9 AM - 5 PM"))
    }
}
