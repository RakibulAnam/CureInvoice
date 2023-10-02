//
//  BookInvestigationForm.swift
//  CareInvoice
//
//  Created by Jotno on 9/25/23.
//

import SwiftUI

struct BookInvestigationForm: View {
    
   
    //@Environment(\.presentationMode) var presentationMode
    
   
    // @State var selectedItem : Investigation?
   
    @State var invoiceGenerated : Bool = false
 
    var totalFee : Double {
        var total = 0.0
        selectedInvestigation.forEach { drug in
            total = total + drug.serviceCharge
        }
        return total
    }
    
    // MARK: - Drug Form Properties
    
    @State var name = ""
    
    @State var contact = ""
    
    @State var searchedText = ""
    
    @StateObject var manager = DiagnosticCenterManager()
    
    @State var selectedInvestigation : [InvestigationModel] = []
    
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var body: some View {
        
        
        ZStack {
            
            
            
            VStack(alignment: .leading){
                
                Text("Investigation Bill")
                    .font(.title)
                
                
                FormTextFieldView(title: "Patient Name", bindingText: $name)
                
                FormTextFieldView(title: "Patient Contact", bindingText: $contact, validate: isValidContact)
                
                Text("Select Investigation")
                    .font(.title)
                    .padding(.top)
                
                TextField("Enter Investigation Name", text: $searchedText)
                    .onChange(of: searchedText, perform: { newValue in
                        if newValue == ""{
                            manager.getInvestigationByName(name: "1")
                        }
                        manager.getInvestigationByName(name: newValue)
                    })
                    .padding(3)
                    .textInputAutocapitalization(.never)
                    .font(.title3)
                    .fontWeight(.light)
                    .autocorrectionDisabled(true)
                    .background(RoundedRectangle(cornerRadius: 3).stroke(Color(.gray), lineWidth: 1))
                
                ZStack{
               
                    
                    List{
                        ForEach(selectedInvestigation) { drug in
                            Text("\(drug.serviceName) - \(Int(drug.serviceCharge))/=")
                        }
                        .onDelete { indexSet in
                            selectedInvestigation.remove(atOffsets:  indexSet)
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
                        List(manager.searchedInvestigationList){ investigation in
                            
                            InvestigationCell(investigation: investigation)
                                .onTapGesture {
                                    print(investigation.serviceName)
                                    selectedInvestigation.append(investigation)
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
                
                
            
                
                NavigationLink(destination: InvestigationInvoiceView(invoice: InvestigationInvoiceModel(p_name: name, contact: contact, org_id: OrgID, investigationDTOList: selectedInvestigation, total: Double(totalFee))), isActive: $invoiceGenerated) {
                    Button {
                        /*
                         let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                         
                         manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                         
                         */
                        
                        /*
                        manager.createInvoice(invoice: DrugInvoiceModel(patientName: name, patientContact: contact, orgId: OrgID, drugList: selectedDrug, total: totalFee))
                        */
                        
                        manager.bookInvestigation(invoice: InvestigationInvoiceModel(p_name: name, contact: contact, org_id: OrgID, investigationDTOList: selectedInvestigation, total: Double(totalFee)))
                        
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





struct BookInvestigationForm_Previews: PreviewProvider {
    static var previews: some View {
        BookInvestigationForm()
    }
}
