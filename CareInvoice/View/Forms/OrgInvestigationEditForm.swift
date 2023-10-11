//
//  OrgInvestigationEditForm.swift
//  CareInvoice
//
//  Created by Jotno on 10/5/23.
//

import SwiftUI

struct OrgInvestigationEditForm: View {
    @State var price : String =  ""
    @StateObject var manager = DiagnosticCenterManager()
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var model : InvestigationModel
    @State var allFilled : Bool = true
    @Environment(\.presentationMode) var presentationMode
    
    init(model : InvestigationModel){
        self.model = model
        self._price = State(initialValue: "\(model.serviceCharge)")
    }
    
    var body: some View {
        
        VStack {
            FormTextFieldView(title: "Price", bindingText: $price)
                .keyboardType(.numberPad)
            
            if allFilled == false {
                Text("Please Enter all Information")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
            }
            Button {
                                
                if price.isEmpty {
                    allFilled = false
                }else {
                    allFilled = true
                    
                    if let id = model.id {
                        print("Got Investigation ID")
                        let updateModel = UpdateOrgInvestigationModel(orgId: OrgID, investigationId: id, serviceCharge: Double(price)!)
                        manager.updateOrgInvestigationPrice(model: updateModel)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                
                
                
                
                
                
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
        }
        .padding()
        
       
    }
}

struct OrgInvestigationEditForm_Previews: PreviewProvider {
    static var previews: some View {
        OrgInvestigationEditForm(model: InvestigationModel(id: 1, serviceName: "TEST INVESTIGATION", serviceCharge: 200.0))
    }
}
