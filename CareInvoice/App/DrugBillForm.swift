//
//  DrugBillView.swift
//  CareInvoice
//
//  Created by Jotno on 9/27/23.
//

import SwiftUI

struct DrugBillForm: View {
    
    
    
    
    // @State var selectedItem : Investigation?
   
    @State var invoiceGenerated : Bool = false
 
    var totalFee : Double {
        var total = 0.0
        selectedDrug.forEach { drug in
            total = total + drug.price
        }
        return total
    }
    
    // MARK: - Drug Form Properties
    
    @State var name = ""
    
    @State var contact = ""
    
    @State var searchedText = ""
    
    @StateObject var manager = Pharmacymanager()
    
    @State var selectedDrug : [DrugModel] = []
    
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var body: some View {
        
    
        
        
        ZStack {
            
            
            
            VStack(alignment: .leading){
                
                Text("Pharma Bill")
                    .font(.title)
                
                
                FormTextFieldView(title: "Patient Name", bindingText: $name)
                
                FormTextFieldView(title: "Patient Contact", bindingText: $contact, validate: isValidContact)
                
                Text("Select Drug")
                    .font(.title)
                    .padding(.top)
                
                TextField("Enter Drug Name", text: $searchedText)
                    .onChange(of: searchedText, perform: { newValue in
                        if newValue == ""{
                            manager.getDrugBrand(name: "1")
                        }
                        manager.getDrugBrand(name: newValue)
                    })
                    .padding(3)
                    .textInputAutocapitalization(.none)
                    .font(.title3)
                    .fontWeight(.light)
                    .autocorrectionDisabled(true)
                    .background(RoundedRectangle(cornerRadius: 3).stroke(Color(.gray), lineWidth: 1))
                
                ZStack{
               
                    
                    List{
                        ForEach(selectedDrug) { drug in
                            Text("\(drug.brandName) - \(Int(drug.price))/=")
                        }
                        .onDelete { indexSet in
                            selectedDrug.remove(atOffsets:  indexSet)
                        }
                    }
                    .listStyle(.plain)
                    
//                    List(selectedDrug){ drug in
//
//
//                        Text("\(drug.brandName) - \(Int(drug.price))/=")
//
//                    }
//                    .listStyle(.plain)
                    
                    
                    if searchedText.isEmpty {
                        
                    } else {
                        List(manager.searchedDrugList){ drug in
                            
                            SearchedDrugCell(drugModel: drug)
                                .onTapGesture {
                                    print(drug.brandName)
                                    selectedDrug.append(drug)
                                    searchedText = ""
                                }
                                .listRowSeparator(.hidden)
                            
                        }
                        .listStyle(.plain)
                    }
                    
                    
                    
                }
                HStack{
                    Text("Total Fee: \(Int(totalFee)) /=")
                }
                .font(.title2)
                
                
            
                
                NavigationLink(destination: DrugInvoiceView(invoice: DrugInvoiceModel(patientName: name, patientContact: contact, orgId: OrgID, drugList: selectedDrug, total: totalFee), hideButton: false), isActive: $invoiceGenerated) {
                    Button {
                        /*
                         let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                         
                         manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                         
                         */
                        
                        manager.createInvoice(invoice: DrugInvoiceModel(patientName: name, patientContact: contact, orgId: OrgID, drugList: selectedDrug, total: totalFee))
                        
                        invoiceGenerated = true
                        
                        
                        
                    } label: {
                        Text("Add".uppercased())
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 60, alignment: .center)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(10)
                            .padding(.vertical)
                        
                    }
                }
                
                
                
                
                
                
                
                
                Spacer()
            } //: VSTACK
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            
            
            
            
        }
    }
    
    
    func isValidContact(_ contact: String) -> Bool {
        let contactRegex = #"^(?:\+88|01)?\d{11}$"#
        let contactPredicate = NSPredicate(format: "SELF MATCHES %@", contactRegex)
        return contactPredicate.evaluate(with: contact)
    }
    
    
}

struct DrugBillView_Previews: PreviewProvider {
    static var previews: some View {
        DrugBillForm()
    }
}
