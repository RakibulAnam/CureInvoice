//
//  AdminFormView.swift
//  CareInvoice
//
//  Created by Jotno on 9/17/23.
//

import SwiftUI

struct OrgAdminFormView: View {
    
    @State var org : OrganizationModel
    @StateObject var manager : OrganizationManager = OrganizationManager()

    @State var name = ""
    @State var email = ""
    @State var contact = ""
    @State var userName = ""
    @State var password = ""
    @AppStorage("OrgID") var OrgID : Int = 0
    @State var errorText = ""
    @State var showAlert = false
    @State var allFilled : Bool = true
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            
           
            
            VStack(alignment: .leading){
                
                Text("Organization Admin for \(org.name)")
                    .font(.title)
                    .lineLimit(nil)
                
                ScrollView(showsIndicators: false){
                    

                    
                    FormTextFieldView(title: "Name", bindingText: $name)
                    FormTextFieldView(title: "UserName", bindingText: $userName)
                    FormTextFieldView(title: "Password", bindingText: $password)
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
                        
                        
                        if name.isEmpty || userName.isEmpty || password.isEmpty || email.isEmpty || contact.isEmpty {
                            allFilled = false
                        }
                        else {
                            let newAdmin = OrgAdminModel(name: name, username: userName.lowercased(), password: password, email: email.lowercased(), contact: contact, orgId: org.id!)
                            
                            print(org.id!)
                            manager.createOrgAdmin(admin: newAdmin, completion: { error in
                                
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
                        
                        
                        
                        
                      
//                        self.presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Text("Add".uppercased())
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

struct OrgAdminFormView_Previews: PreviewProvider {
    static var previews: some View {
        OrgAdminFormView(org: OrganizationModel(name: "Ibne Sinha", address: "Dhaka", contact: "01677397270", type: "Hospital", email: "ibne@gmail.com", emergencyContact: "01911362438", operatingHour: "9 AM - 5 PM", orgCode: "KHR"))
    }
}
