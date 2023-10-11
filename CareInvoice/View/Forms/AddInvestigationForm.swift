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
    @StateObject var manager = OrganizationManager()
    
    var profile : InvestigationModel?
    
    @State var title = "Add Investigation"
    @State var buttonName = "Add"
    @State var allFilled : Bool = true
    
    @State var errorText = ""
    @State var showAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    
    
    init(profile : InvestigationModel? = nil){
        self.profile = profile
        
        if let org = profile {
            self._name = State(initialValue: org.serviceName)
            self._fee = State(initialValue: String(org.serviceCharge))
            self._title = State(initialValue: String("Edit Investigation"))
            self._buttonName = State(initialValue: String("Update"))
        }
    }
    
    var body: some View {
        
        ZStack {
        
            VStack(alignment: .leading){
                
                Text(title)
                    .font(.title)
                
                ScrollView(showsIndicators: false){
                    

                    
                    FormTextFieldView(title: "Name", bindingText: $name)
                    FormTextFieldView(title: "Fee", bindingText: $fee)
                        .keyboardType(.numberPad)
                    
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
                        
                        if name.isEmpty || fee.isEmpty {
                            allFilled = false
                        }else {
                            let newInvestigation = InvestigationModel(serviceName: name, serviceCharge: Double(fee)!)
                            
                            if let profile = profile {
                                manager.updateInvestigation(investigation: newInvestigation, investigationId: profile.id!, completion: {sucess in
                                    switch sucess {
                                    case .duplicate :
                                        print("YES")
                                        errorText = "The Investigation already exists"
                                        showAlert = true
                                    case nil:
                                        DispatchQueue.main.async {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                        print("NO")
                                    }
                                })
                            }else {
                                manager.addInvestigation(investigation: newInvestigation, completion: {sucess in
                                    switch sucess {
                                    case .duplicate :
                                        print("YES")
                                        errorText = "The Investigation already exists"
                                        showAlert = true
                                    case nil:
                                        DispatchQueue.main.async {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                        print("NO")
                                    }
                                })
                            }
                            
                            
                          
                            
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
        
    }
}

struct AddInvestigationForm_Previews: PreviewProvider {
    static var previews: some View {
        AddInvestigationForm()
    }
}
