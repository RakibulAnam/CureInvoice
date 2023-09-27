//
//  AddInvestigationForm.swift
//  CareInvoice
//
//  Created by Jotno on 9/25/23.
//

import SwiftUI

struct AddInvestigationForm: View {
    
    @State var name = ""
    @State var fee = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
        
            VStack(alignment: .leading){
                
                Text("Add Investigation")
                    .font(.title)
                
                ScrollView(showsIndicators: false){
                    

                    
                    FormTextFieldView(title: "Name", bindingText: $name)
                    FormTextFieldView(title: "Fee", bindingText: $fee)
                    
                    
                    
                    Button {
                        /*
                        let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                        
                        manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                         
                        */
                      
                        self.presentationMode.wrappedValue.dismiss()
                        
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
                    
                }//: SCROLL
                
            } //: VSTACK
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            
            
            
        }//: ZSTACK
        
    }
}

struct AddInvestigationForm_Previews: PreviewProvider {
    static var previews: some View {
        AddInvestigationForm()
    }
}
