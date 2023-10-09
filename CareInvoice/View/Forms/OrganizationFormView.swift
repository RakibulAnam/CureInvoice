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
    @State var orgCode = ""
    @State var errorText = ""
    @State var showAlert = false
    
//    @Binding var name : String
//    @Binding var address : String
//    @Binding var email : String
//    @Binding var contact : String
//    @Binding var emergencyContact : String
//    @Binding var operatingHour : String
    @State var buttonName : String = "Create"
    @State var formTitle : String = "Create New Organization"
    
    
    @Environment(\.presentationMode) var presentationMode
    
    
    init(manager: OrganizationManager, profile: OrganizationModel? = nil, orgType: String) {
        self.manager = manager
        self.profile = profile
        self.orgType = orgType
        if let org = profile {
            self._name = State(initialValue: org.name)
            self._orgCode = State(initialValue: org.orgCode ?? "DEFAULT")
            self._address = State(initialValue: org.address)
            self._email = State(initialValue: org.email)
            self._contact = State(initialValue: org.contact)
            self._emergencyContact = State(initialValue: org.emergencyContact)
            self._operatingHour = State(initialValue: org.operatingHour)
            self._buttonName = State(initialValue: "Update")
            self._formTitle = State(initialValue: "Edit Organization")
        }
    }
    
    
    var body: some View {
        
        
        
        ZStack {
                        
            VStack(alignment: .leading){
                
                Text(formTitle)
                    .font(.title)
                
                ScrollView(showsIndicators: false){
                    

                    
                    FormTextFieldView(title: "Name", bindingText: $name)
                    FormTextFieldView(title: "Organization Code", bindingText: $orgCode)
                    FormTextFieldView(title: "Address", bindingText: $address)
                    FormTextFieldView(title: "Email", bindingText: $email, validate: isValidEmail)
                    FormTextFieldView(title: "Contact", bindingText: $contact, validate: isValidContact)
                        .keyboardType(.phonePad)
                    FormTextFieldView(title: "Emergency Contact", bindingText: $emergencyContact, validate: isValidContact)
                        .keyboardType(.phonePad)
                    FormTextFieldView(title: "Operating Hour", bindingText: $operatingHour)
                    
                    
                    Button {
                        let newOrg = OrganizationModel(name: name, address: address, contact: contact, type: orgType, email: email.lowercased(), emergencyContact: emergencyContact, operatingHour: operatingHour, orgCode: orgCode)
                        if let profile = profile {
                            manager.updateOrganization(organization: newOrg, to: K.UPDATE_ORGANIZATION, for: profile.id!, completion: { error in
                                
                                switch error {
                                case .urlProblem :
                                    errorText = "There Was a Problem Reaching the Server"
                                    showAlert = true
                                
                                case .duplicateData:
                                    errorText = "The Email and Org Code Must be unique, please try again"
                                    showAlert = true
                                    
                                case nil :
                                    print("Success")
                                    DispatchQueue.main.async {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                   
                                
                                case .some(.emptyTextField):
                                    errorText = "Please Enter All Information"
                                    showAlert = true
                                }
                                
                            })
//                            self.presentationMode.wrappedValue.dismiss()
                        }else{
                            manager.postOrganization(organization: newOrg, to: K.CREATE_ORGANIZATION, completion: { error in
                                
                                switch error {
                                case .urlProblem :
                                    errorText = "There Was a Problem Reaching the Server"
                                    showAlert = true
                                case nil:
                                    print("Success")
                                    DispatchQueue.main.async {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                case .some(.duplicateData):
                                    errorText = "The Email and Org Code Must be unique, please try again"
                                    showAlert = true
                                
                                case .some(.emptyTextField):
                                    errorText = "Please Enter All Information"
                                    showAlert = true
                                }
                                
                            })
                        }
                        
                        
                    } label: {
                        Text(buttonName.uppercased())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 60, alignment: .center)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(10)
                            .padding(.vertical)
                        
                    } //: BUTTON
                    .alert(errorText, isPresented: $showAlert){
                        Button("OK", role: .cancel) {
                            
                        }
                    }
                    
                }//: SCROLL
                
            } //: VSTACK
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            
            
        }//: ZSTACK
        .onAppear{
            if profile != nil {
                formTitle = " Update \(orgType)"
            } else {
                formTitle = "Create New \(orgType)"
            }
            
        }
        
        
        
        
        
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

    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    func isValidContact(_ contact: String) -> Bool {
        let contactRegex = #"^(?:\+88|01)?\d{11}$"#
        let contactPredicate = NSPredicate(format: "SELF MATCHES %@", contactRegex)
        return contactPredicate.evaluate(with: contact)
    }
    
}

struct OrganizationFormView_Previews: PreviewProvider {
    static var previews: some View {
        OrganizationFormView(manager: OrganizationManager(), orgType: K.OrgType.HOSPITAL)
    }
}
