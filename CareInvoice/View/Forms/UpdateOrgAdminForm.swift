//
//  UpdateOrgAdminForm.swift
//  CareInvoice
//
//  Created by Jotno on 10/10/23.
//

import SwiftUI

struct UpdateOrgAdminForm: View {
    @Environment(\.presentationMode) var presentationMode
    @State var model : OrgAdminModel
    @State var name = ""
    @State var email = ""
    @State var contact = ""
    @State var userName = ""
    @State var password = ""
    @AppStorage("OrgID") var OrgID : Int = 0
    @State var errorText = ""
    @State var showAlert = false
    var manager = OrganizationManager()
    
    
    
    init(model : OrgAdminModel){
        self._model = State(initialValue: model)
        self._name = State(initialValue: model.name)
        self._email = State(initialValue: model.email)
        self._contact = State(initialValue: model.contact)
        self._userName = State(initialValue: model.username)
        
       
    }
    
    
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading){
                
                Text("Update Organization Admin")
                    .font(.title)
                
                ScrollView(showsIndicators: false){
                    

                    
                    FormTextFieldView(title: "Name", bindingText: $name)
                    FormTextFieldView(title: "UserName", bindingText: $userName)
                    //FormTextFieldView(title: "Password", bindingText: $password)
                    FormTextFieldView(title: "Email", bindingText: $email, validate: isValidEmail)
                    FormTextFieldView(title: "Contact", bindingText: $contact, validate: isValidContact)
                        .keyboardType(.phonePad)
                    
                    
                    
                    
                    Button {
                        let newAdmin = OrgAdminModel(name: name, username: userName.lowercased(), password: nil, email: email.lowercased(), contact: contact, orgId: model.orgId)
                        
                      
                        manager.updateOrgAdmin(model: newAdmin, adminId: model.id!  ,completion: { error in
                            
                            switch error {
                            case .urlProblem :
                                errorText = "There Was a Problem Reaching the Server"
                                showAlert = true
                            
                            case .duplicateData:
                                errorText = "The Username and Email must be unique, please try again"
                                showAlert = true
                                
                            case .some(.emptyTextField):
                                errorText = "Please Enter All Information"
                                showAlert = true
                                
                            case nil :
                                print("Success")
                                DispatchQueue.main.async {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                               
                            
                            }
                            
                        })
                        
                      
//                        self.presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Text("Update".uppercased())
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

struct UpdateOrgAdminForm_Previews: PreviewProvider {
    static var previews: some View {
        UpdateOrgAdminForm(model: OrgAdminModel(name: "Rohid", username: "roro1", password: "123456", email: "ceo@gmail.com", contact: "019123232", orgId: 23))
    }
}
