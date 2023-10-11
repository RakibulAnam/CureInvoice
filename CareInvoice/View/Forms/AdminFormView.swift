//
//  AdminForm.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct AdminFormView: View {
    
    
    @State var name = ""
    @State var email = ""
    @State var contact = ""
    @State var userName = ""
    @State var password = ""
    @AppStorage("OrgID") var OrgID : Int = 0
    @AppStorage("OrgType") var OrgType : String = ""
     var buttonName = "Add"
    var title = "Create"
    
    @State var errorText = ""
    @State var showAlert = false
    
    var profile : AdminModel?
    
    
    
    
    @StateObject var pharmacyManager = Pharmacymanager()
    @StateObject var diagnosticManager = DiagnosticCenterManager()
    @StateObject var hospitalManager = HospitalManager()
    
    @State var allFilled : Bool = true
    
    @Environment(\.presentationMode) var presentationMode
    
    init(profile: AdminModel? = nil){
        self.profile = profile
        if let model = profile {
            self._name = State(initialValue: model.name)
            self._email = State(initialValue: model.email)
            self._contact = State(initialValue: model.contact)
            self._userName = State(initialValue: model.username)
            self._password = State(initialValue: "0")
            self.buttonName = "Update"
            self.title = "Edit"
        }
    }
    
    
    var body: some View {
        
        ZStack {
            
           
            
            VStack(alignment: .leading){
                
                Text("\(title) Admin")
                    .font(.title)
                
                ScrollView(showsIndicators: false){
                    

                    
                    FormTextFieldView(title: "Name", bindingText: $name)
                    FormTextFieldView(title: "UserName", bindingText: $userName)
                    
                    if profile == nil{
                        FormTextFieldView(title: "Password", bindingText: $password)
                    }
                    FormTextFieldView(title: "Email", bindingText: $email, validate: isValidEmail)
                    FormTextFieldView(title: "Contact", bindingText: $contact, validate: isValidContact)
                        .keyboardType(.phonePad)
                    
                    if allFilled == false {
                        Text("Please Enter all Information")
                            .font(.headline)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    
                    Button {
                        /*
                        let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                        
                        manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                         
                        */
                        
                        if name.isEmpty ||  userName.isEmpty || password.isEmpty || email.isEmpty || contact.isEmpty {
                            allFilled = false
                        }else {
                            if let profile = profile {
                                let newAdmin = AdminModel(name: name, username: userName.lowercased(), password: nil, email: email.lowercased(), contact: contact, orgId: OrgID)
                                
                                if OrgType == K.OrgType.PHARMACY{
                                    pharmacyManager.updateAdmin(model: newAdmin,adminId: profile.id!, completion: { error in
                                        
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
                                }
                                else if OrgType == K.OrgType.DIAGNOSTIC_CENTER {
                                    diagnosticManager.updateAdmin(model: newAdmin,adminId: profile.id!, completion: { error in
                                        
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
                                }
                                else if OrgType == K.OrgType.HOSPITAL {
                                    hospitalManager.updateAdmin(model: newAdmin,adminId: profile.id!, completion: { error in
                                        
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
                                }
                                
                            }
                            else {
                                let newAdmin = AdminModel(name: name, username: userName.lowercased(), password: password, email: email.lowercased(), contact: contact, orgId: OrgID)
                                
                                print(OrgID)
                                if OrgType == K.OrgType.PHARMACY{
                                    pharmacyManager.createAdmin(admin: newAdmin, completion: { error in
                                        
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
                                }
                                else if OrgType == K.OrgType.DIAGNOSTIC_CENTER {
                                    diagnosticManager.createAdmin(admin: newAdmin, completion: { error in
                                        
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
                                }
                                else if OrgType == K.OrgType.HOSPITAL {
                                    hospitalManager.createAdmin(admin: newAdmin, completion: { error in
                                        
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
                                }
                            }
                        }
                        
                        
                        
                       
                        
                        
                      
                        //self.presentationMode.wrappedValue.dismiss()
                        
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

struct AdminFormView_Previews: PreviewProvider {
    static var previews: some View {
        AdminFormView()
    }
}
