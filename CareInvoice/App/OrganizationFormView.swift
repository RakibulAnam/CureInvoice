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
        }
    }
    
    
    var body: some View {
        
 
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
                    
                    
                    let newHospital = OrganizationModel(name: name, address: address, contact: contact, type: orgType, email: email.lowercased(), emergencyContact: emergencyContact, operatingHour: operatingHour)
                    
                    manager.postOrganization(organization: newHospital, to: K.CREATEORGANIZATION)
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("Create".uppercased())
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
        }
        
        
    }
}

struct OrganizationFormView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationFormView(manager: OrganizationManager(), orgType: K.OrgType.HOSPITAL )
    }
}
