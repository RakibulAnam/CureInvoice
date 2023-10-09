//
//  OrgDrugEditForm.swift
//  CareInvoice
//
//  Created by Jotno on 10/4/23.
//

import SwiftUI

struct OrgDrugEditForm: View {
    
    @State var price : String = ""
    @State var quantity : String = ""
    @StateObject var manager = Pharmacymanager()
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var drugModel : DrugModel
    
    @Environment(\.presentationMode) var presentationMode
    
    init(drugModel : DrugModel){
        self.drugModel = drugModel
        self._price = State(initialValue: "\(drugModel.price)")
        self._quantity = State(initialValue: "\(drugModel.quantity ?? 0)")
    }
    
    var body: some View {
        ZStack {
        
            VStack(alignment: .leading){
                
                
                
                ScrollView(showsIndicators: false){
                    

                    
                    FormTextFieldView(title: "Price", bindingText: $price)
                    FormTextFieldView(title: "Quantity", bindingText: $quantity)
                    
                    
                    Button {
                        /*
                        let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                        
                        manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                         
                        */
                        
                        
                        
//                        if let profile = profile {
//                            manager.updateInvestigation(investigation: newInvestigation, investigationId: profile.id!)
//                        }else {
//                            manager.addInvestigation(investigation: newInvestigation)
//                        }
                        
           //             let spec = SpecialityListModel(medSpecName: medSpecName, iconUrl: "stethoscope.png")
                        
//                        if let profile = profile {
//                            manager.updateSpeciality(speciality: spec, specialityId: profile.id!)
//                        }else {
//                            manager.addSpeciality(speciality: spec)
//                        }
                        
                        
                        let updateModel = UpdateOrgDrugModel(orgId: OrgID, drugId: drugModel.id!, price: Double(price)!, quantity: Int(quantity)!)
                        
                        print(drugModel.id!)
                        print(OrgID)
                        if let id = drugModel.id {
                            print("Got DRUG ID")
                            manager.updateOrgDrugDetails(model: UpdateOrgDrugModel(orgId: OrgID, drugId: id, price: Double(price)!, quantity: Int(quantity)!))
                        }
                        
                        
                        self.presentationMode.wrappedValue.dismiss()
                        
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
                    
                }//: SCROLL
                
            } //: VSTACK
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            
            
            
        }//: ZSTACK
    }
}

struct OrgDrugEditForm_Previews: PreviewProvider {
    static var previews: some View {
        OrgDrugEditForm(drugModel: DrugModel(id: 1, brandName: "asd", price: 100.0, vendorName: "qwe", genericName: "qwe", formationName: "qwe", strengthName: "Qwe"))
    }
}
