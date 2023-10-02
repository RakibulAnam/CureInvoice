//
//  AddDrugForm.swift
//  CareInvoice
//
//  Created by Jotno on 10/2/23.
//

import SwiftUI

struct AddDrugForm: View {
    
    @State var brandName = ""
    @State var vendorName = "ACI"
    @State var generic = "ACARBOSE"
    @State var formation = "GEL"
    @State var strength = "(1gm+500mg)/100ml"
    @State var price = ""
    @State var title = "Add Drug"
    @State var buttonName = "Add"
    @StateObject var manager = OrganizationManager()
    let doctorNames = ["Dr. Smith", "Dr. Johnson", "Dr. Williams", "Dr. Brown", "Dr. Jones"]
    @Environment(\.presentationMode) var presentationMode
    
    var profile : DrugModel?
    
    
    init(profile : DrugModel? = nil){
        self.profile = profile
        
        if let org = profile {
            self._brandName = State(initialValue: org.brandName)
            self._vendorName = State(initialValue: org.vendorName)
            self._generic = State(initialValue: org.genericName)
            self._formation = State(initialValue: org.formationName)
            self._strength = State(initialValue: org.strengthName)
            self._price = State(initialValue: String(org.price))
            self.title = "Edit Drug"
            self.buttonName = "Update"
        }
    }
    
    var body: some View {
        ZStack {
            
            ScrollView {
                VStack(alignment: .leading){
                    
                    Text(title)
                        .font(.title)
                    
                        
                    VStack (alignment: .leading, spacing: 20) {
                        FormTextFieldView(title: "Brand Name", bindingText: $brandName)
                        
                        VStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Vendor Name")
                                    .font(.title3)
                                    .fontWeight(.light)
                                
                                Picker("", selection: $vendorName) {
                                    ForEach(manager.drugList, id: \.vendorName) { item in
                                        Text(item.vendorName)
                                    }
                                }
                                .frame(width: 350)
                                          .pickerStyle(MenuPickerStyle())
                                          .padding(6)
                                          .background(
                                          RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color(.gray))
                                          )
                                
                            }
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Generic")
                                    .font(.title3)
                                    .fontWeight(.light)
                                
                                Picker("", selection: $generic) {
                                    ForEach(manager.drugList, id: \.genericName) { item in
                                        Text(item.genericName)
                                    }
                                }
                                .frame(width: 350)
                                          .pickerStyle(MenuPickerStyle())
                                          .padding(6)
                                          .background(
                                          RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color(.gray))
                                          )
                                
                            }
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Formation")
                                    .font(.title3)
                                    .fontWeight(.light)
                                
                                Picker("", selection: $formation) {
                                    ForEach(manager.drugList, id: \.formationName) { item in
                                        Text(item.formationName)
                                    }
                                }
                                .frame(width: 350)
                                          .pickerStyle(MenuPickerStyle())
                                          .padding(6)
                                          .background(
                                          RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color(.gray))
                                          )
                                
                            }
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Strength")
                                    .font(.title3)
                                    .fontWeight(.light)
                                
                                Picker("", selection: $strength) {
                                    ForEach(manager.drugList, id: \.strengthName) { item in
                                        Text(item.strengthName)
                                    }
                                }
                                .frame(width: 350)
                                          .pickerStyle(MenuPickerStyle())
                                          .padding(6)
                                          .background(
                                          RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color(.gray))
                                          )
                                
                            }
                        }
                        
                      
                        
                        
                        
                        
                    }//FORM VSTACK
                    
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Price")
                            .font(.title3)
                            .fontWeight(.light)
                        TextField("", text: $price)
                            .padding(10)
                            .textInputAutocapitalization(.never)
                            .font(.title3)
                            .fontWeight(.light)
                            .autocorrectionDisabled(true)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color(.gray), lineWidth: 1))
                            .keyboardType(.numberPad)
                    }
                        
                   
                    Button {
                        /*
                        let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                        
                        manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                         
                        */
                        
                        let newDrug = DrugModel(brandName: brandName, price: Double(price)!, vendorName: vendorName, genericName: generic, formationName: formation, strengthName: strength)
                        
                        if let profile = profile {
                            manager.updateDrug(drug: newDrug, drugID: profile.id!)
                        }
                        else{
                            manager.createDrug(drug: newDrug)
                        }
                        
                      
                        self.presentationMode.wrappedValue.dismiss()
                        
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
                    
                        
                            
                }
                .padding()
            }
            
     
            } //: VSTACK
            
            .onAppear{
                manager.getAllGlobalDrugs()
            }
            
            
            
        }
    }


struct AddDrugForm_Previews: PreviewProvider {
    static var previews: some View {
        AddDrugForm()
    }
}
