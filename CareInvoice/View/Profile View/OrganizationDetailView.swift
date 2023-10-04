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
                
                /*
                 ScrollView(showsIndicators: false) {
                 
                 if let nOrg = manager.orgModel{
                 
                 VStack(alignment: .center, spacing: 10){
                 
                 Image("organization")
                 .resizable()
                 .frame(width: 150, height: 150, alignment: .center)
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
                 
                 
                 }//Vstack
                 .padding()
                 
                 AdminListView(org: OrganizationModel(name: "TestOrg", address: "TEst", contact: "test", type: "test", email: "test", emergencyContact: "test", operatingHour: "test", admin: [OrgAdminModel(id: 1, name: "Rohid", username: "rohid", password: "123123123", email: "rohid@gmail.com", contact: "01911362438"), OrgAdminModel(id: 2,  name: "Mohit", username: "mohid", password: "123123123", email: "mohit@gmail.com", contact: "01911362438")]))
                 
                 } //: IfLET
                 
                 
                 
                 }//ScrollView
                 */
                
                if let nOrg = manager.orgModel{
                    
                    VStack(alignment: .center, spacing: 20){
                        
                        VStack{
                            Image("organization")
                                .resizable()
                                .frame(width: 150, height: 150, alignment: .center)
                                .scaledToFit()
                            
                            Text(nOrg.name)
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(Color("PrimaryColor"))
                            
                            Text(nOrg.address)
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                        }
                        
                        
                        
                        
                        
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
                        
                        VStack(alignment: .leading){
                            
                            HStack{
                                Text("Admins")
                                    .font(.title)
                                Spacer()
                                
                                NavigationLink(destination: OrgAdminFormView(org: nOrg)) {
                                    Image(systemName: "cross")                                }
                                
                            }
                            
                            
                            OrgAdminListView(org: nOrg)
                            
                            
                        }
                        .frame(alignment: .leading)
                        
                        
                        
                    }//Vstack
                    .padding()
                    
                    
                    
                } //: IfLET
                
                
                
                //ScrollView
                
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
        .navigationTitle("")
        .onAppear {
            DispatchQueue.main.async {
                manager.getSingleOrganization(from: K.GET_ORGANIZATION_BY_ID, for: org.id ?? 1)
            }
            // manager.getSingleOrganization(from: K.GETORGANIZATIONBYID, for: org.id ?? 1)
        }
        
        
    }
}

struct OrganizationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationDetailView(org: OrganizationModel(name: "Ibne Sinha", address: "Dhaka", contact: "01677397270", type: "Hospital", email: "ibne@gmail.com", emergencyContact: "01911362438", operatingHour: "9 AM - 5 PM", orgCode: "KHR"), listUrl: K.Hospitals.GETALLHOSPITAL)
    }
}
