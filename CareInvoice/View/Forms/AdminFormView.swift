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
    
    @StateObject var pharmacyManager = Pharmacymanager()
    @StateObject var diagnosticManager = DiagnosticCenterManager()
    @StateObject var hospitalManager = HospitalManager()
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        ZStack {
            
           
            
            VStack(alignment: .leading){
                
                Text("Create Admin")
                    .font(.title)
                
                ScrollView(showsIndicators: false){
                    

                    
                    FormTextFieldView(title: "Name", bindingText: $name)
                    FormTextFieldView(title: "UserName", bindingText: $userName)
                    FormTextFieldView(title: "Password", bindingText: $password)
                    FormTextFieldView(title: "Email", bindingText: $email, validate: isValidEmail)
                    FormTextFieldView(title: "Contact", bindingText: $contact, validate: isValidContact)
                    
                    
                    
                    
                    Button {
                        /*
                        let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                        
                        manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                         
                        */
                        
                        let newAdmin = AdminModel(name: name, username: userName.lowercased(), password: password, email: email.lowercased(), contact: contact, orgId: OrgID)
                        
                        print(OrgID)
                        if OrgType == K.OrgType.PHARMACY{
                            pharmacyManager.createAdmin(admin: newAdmin)
                        }
                        else if OrgType == K.OrgType.DIAGNOSTIC_CENTER {
                            diagnosticManager.createAdmin(admin: newAdmin)
                        }
                        else if OrgType == K.OrgType.HOSPITAL {
                            hospitalManager.createAdmin(admin: newAdmin)
                        }
                        
                        
                      
                        self.presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Text("Create".uppercased())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 60, alignment: .center)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(10)
                            .padding(.vertical)
                        
                    } //: BUTTON
                    
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
