//
//  OrganizationFormView.swift
//  CareInvoice
//
//  Created by Jotno on 9/13/23.
//

import SwiftUI

struct OrganizationFormView: View {
    
    var manager : OrganizationManager
    var profile : OrganizationModel?
    var orgType : String
    
    @State var name = ""
    @State var address = ""
    @State var email = ""
    @State var contact = ""
    @State var emergencyContact = ""
    @State var operatingHour = ""
    @State var buttonName : String = "Create"
    
    
    @Environment(\.presentationMode) var presentationMode
    
    
    init(manager: OrganizationManager, profile: OrganizationModel? = nil, orgType: String) {
        self.manager = manager
        self.profile = profile
        self.orgType = orgType
        if let org = profile {
            self._name = State(initialValue: org.name)
            self._address = State(initialValue: org.address)
            self._email = State(initialValue: org.email)
            self._contact = State(initialValue: org.contact)
            self._emergencyContact = State(initialValue: org.emergencyContact)
            self._operatingHour = State(initialValue: org.operatingHour)
            self._buttonName = State(initialValue: "Update")
        }
    }
    
    
    var body: some View {
     
        
        
        VStack(alignment: .leading){
                
                
            ScrollView{
                
                VStack(alignment: .leading , spacing: 5){
                    Text("Name")
                    TextField("", text: $name)
                        .padding() // Add padding for spacing
                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color("PrimaryColor"), lineWidth: 2)) // Apply a rounded border
                        .foregroundColor(.blue) // Text color
                        .padding()
                }
                
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Address")
                    TextField("", text: $name)
                        .padding()
                        .border(.black)
                        .cornerRadius(5)
                }.padding(.horizontal, 10)
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Email")
                    TextField("", text: $name)
                        .padding()
                        .border(.black)
                        .cornerRadius(5)
                }.padding(.horizontal, 10)
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Contact")
                    TextField("", text: $name)
                        .padding()
                        .border(.black)
                        .cornerRadius(5)
                }.padding(.horizontal, 10)
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Emergency Contact")
                    TextField("", text: $name)
                        .padding()
                        .border(.black)
                        .cornerRadius(5)
                }.padding(.horizontal, 10)
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Operating Hour")
                    TextField("", text: $name)
                        .padding()
                        .border(.black)
                        .cornerRadius(5)
                }.padding(.horizontal, 10)
                
                
                Button {
                    
                    
                    let newOrg = OrganizationModel(name: name, address: address, contact: contact, type: orgType, email: email.lowercased(), emergencyContact: emergencyContact, operatingHour: operatingHour)
                    
                    if let profile = profile {
                        manager.updateOrganization(organization: newOrg, to: K.UPDATEORGANIZATION, for: profile.id!)
                    }else{
                        manager.postOrganization(organization: newOrg, to: K.CREATEORGANIZATION)
                    }
                    
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text(buttonName.uppercased())
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50, alignment: .center)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(10)
                    .padding()
                } //: BUTTON
                
            }//: SCROLL
            
                
            
            
            
                
                
//                Form {
//                    Section("Name") {
//                        TextField("Organization Name", text: $name)
//                            .textFieldStyle(.roundedBorder)
//
//                    }
//
//                    Section("Address") {
//                        TextField("Address", text: $address)
//                    }
//
//                    Section("Operating Hour") {
//                        TextField("Operating Hour", text: $operatingHour)
//                    }
//
//                    Section("Email") {
//                        TextField("Email", text: $email)
//                    }
//
//                    Section("Contact") {
//                        TextField("Contact", text: $contact)
//                    }
//
//                    Section("Emergency Contact") {
//                        TextField("Emergency Contact", text: $emergencyContact)
//                    }
//
//                }
                
                


                Spacer()
            }
        .padding()
            
            
        
        
 /*
        NavigationView {
            VStack{
                
                Form {
                    Section("Organization Details") {
                        TextField("Organization Name", text: $name)
                        TextField("Address", text: $address)
                        TextField("Operating Hour", text: $operatingHour)
                    }
                    
                    Section("Contact Details"){
                        TextField("Email", text: $email)
                        TextField("Contact", text: $contact)
                        TextField("Emergency Contact", text: $emergencyContact)
                    }
                }
                
                
                Button {
                    
                    
                    let newOrg = OrganizationModel(name: name, address: address, contact: contact, type: orgType, email: email.lowercased(), emergencyContact: emergencyContact, operatingHour: operatingHour)
                    
                    if let profile = profile {
                        manager.updateOrganization(organization: newOrg, to: K.UPDATEORGANIZATION, for: profile.id!)
                    }else{
                        manager.postOrganization(organization: newOrg, to: K.CREATEORGANIZATION)
                    }
                    
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text(buttonName.uppercased())
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50, alignment: .center)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(10)
                    .padding()
                }

                Spacer()
            }
            .navigationTitle("Create Organization")
            .toolbar(.hidden, for: .navigationBar)
        }
   */
        
    }
}

struct OrganizationFormView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationFormView(manager: OrganizationManager(), orgType: K.OrgType.HOSPITAL)
    }
}
