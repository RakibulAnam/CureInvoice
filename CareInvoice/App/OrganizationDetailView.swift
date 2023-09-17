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
    @State var listUrl : String
    @StateObject private var manager = OrganizationManager()
    
    @State var name = ""
    @State var address = ""
    @State var email = ""
    @State var contact = ""
    @State var emergencyContact = ""
    @State var operatingHour = ""
    
    //MARK: - BODY
    var body: some View {
        
        
            ZStack(alignment: .bottomTrailing) {
                
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    
                    ScrollView(showsIndicators: false) {
                        
                        if let nOrg = manager.orgModel{
                            
                                VStack(alignment: .center, spacing: 10){
                                    
                                    Image("organization")
                                        .resizable()
                                        .frame(maxWidth: .infinity)
                                        .scaledToFit()
                                    
                                    Text(nOrg.name)
                                        .font(.largeTitle)
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color("PrimaryColor"))
                                    
                                    Text(nOrg.address)
                                        .font(.title2)
                                        .fontWeight(.medium)
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .leading, spacing: 5){
                                        Text("Contact: \(nOrg.contact)")
                                        
                                        Text("Email: \(nOrg.email)")
                                        
                                        Text("Operating Hour: \(nOrg.operatingHour)")
                                    }
                                    .padding()
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 1)
                                        .foregroundColor(Color("Symboltint"))
                                    )
                                    //Vstack
                                    
                                    Text("Admins")
                                    
                                  
                                    
                                }//Vstack
                                .padding()
                                
                        } //: IfLET
                        
                      
                        
                        
                    }//ScrollView
                    
                    
                   
                     
                    
                    /*
                     
                     if let nOrg = manager.orgModel{
                     ZStack {
                     VStack(alignment: .center, spacing: 10){
                     
                     Image("organization")
                     .resizable()
                     .frame(maxWidth: .infinity)
                     .scaledToFit()
                     
                     Text(nOrg.name)
                     .font(.largeTitle)
                     .fontWeight(.heavy)
                     .foregroundColor(Color("PrimaryColor"))
                     
                     Text(nOrg.address)
                     .font(.title2)
                     .fontWeight(.medium)
                     .foregroundColor(.secondary)
                     
                     Spacer()
                     
                     VStack(alignment: .leading, spacing: 5){
                     Text("Contact: \(nOrg.contact)")
                     
                     Text("Email: \(nOrg.email)")
                     
                     Text("Operating Hour: \(nOrg.operatingHour)")
                     }
                     .padding()
                     .font(.headline)
                     .frame(maxWidth: .infinity, alignment: .leading)
                     .background(
                     RoundedRectangle(cornerRadius: 5)
                     .stroke(lineWidth: 1)
                     .foregroundColor(Color("Symboltint"))
                     )
                     //Vstack
                     Spacer()
                     }//Vstack
                     .padding()
                     
                     }//Zstack
                     }
                     */
                    
                    
                    
                    
                  
                    
                }//:Vstack
                
                
                NavigationLink(destination: OrganizationFormView(manager: manager, profile: org, orgType: org.type).navigationBarTitleDisplayMode(.inline)) {
                Image(systemName: "pencil")
                .font(.title.weight(.semibold))
                .padding()
                .background(Color("PrimaryColor"))
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 4, x: 0, y: 4)
                }.padding() //: FLOATING BUTTON
                
            }//:Zstack
            .onAppear {
                manager.getSingleOrganization(from: K.GETORGANIZATIONBYID, for: org.id ?? 1)
            }
           
        
    }
}

struct OrganizationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationDetailView(org: OrganizationModel(name: "Ibne Sinha", address: "Dhaka", contact: "01677397270", type: "Hospital", email: "ibne@gmail.com", emergencyContact: "01911362438", operatingHour: "9 AM - 5 PM"), listUrl: K.Hospitals.GETALLHOSPITAL)
    }
}
