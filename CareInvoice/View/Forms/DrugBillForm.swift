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
    @StateObject var orgManager = OrganizationManager()
    @State var orgModel : OrganizationModel
 
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
    
    @State var searchedPatient = ""
    
    @StateObject var manager = Pharmacymanager()
    
    @State var selectedDrug : [DrugModel] = []
    
    @State var patientId : Int?
    
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var body: some View {
        
    
        
        
        ZStack {
            
            
            ScrollView {
                VStack(alignment: .leading){
                    
                    Text("Pharma Bill")
                        .font(.title)
                    
                    
                    HStack() {
                        Image(systemName: "magnifyingglass.circle")
                        TextField("Search Patient", text: $searchedPatient)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .padding(.horizontal, 20)
                            .onChange(of: searchedPatient) { newValue in
                               
                                manager.getPatientList(orgId: OrgID, name: newValue)
                            }
                    }
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    
                    ZStack{
                        
                        if searchedPatient.isEmpty {
                            VStack{
                                FormTextFieldView(title: "Patient Name", bindingText: $name)
                                
                                FormTextFieldView(title: "Patient Contact", bindingText: $contact, validate: isValidContact)
                                    .keyboardType(.phonePad)
                            }
                        } else {
                            
                            List{
                                ForEach(manager.patientList) { item in
                                    PatientCell(patModel: item)
                                        .onTapGesture {
                                            name = item.name
                                            contact = item.contact
                                            patientId = item.id
                                            searchedPatient = ""
                                        }
                                }
                                .listRowInsets(EdgeInsets())
                            }
                            .frame(width: 300, height: 200)
                            .listStyle(.plain)
                            
                        }
                        
                        
                        
                    }.ignoresSafeArea(.keyboard, edges: .bottom)
                    
                    
                    
                    
                    Text("Select Drug")
                        .font(.title)
                        .padding(.top)
                    
                    TextField("Enter Drug Name", text: $searchedText)
                        .onChange(of: searchedText, perform: { newValue in
                            if newValue == ""{
                                manager.getDrugBrand(name: "1")
                            }
                            manager.searchDuringOrder(orgId: OrgID, name: newValue)
                        })
                        .padding(3)
                        .textInputAutocapitalization(.none)
                        .font(.title3)
                        .fontWeight(.light)
                        .autocorrectionDisabled(true)
                        .background(RoundedRectangle(cornerRadius: 3).stroke(Color(.gray), lineWidth: 1))
                        
                    
                    ZStack{
                   
                   
                        
    //                    List(selectedDrug){ drug in
    //
    //
    //                        Text("\(drug.brandName) - \(Int(drug.price))/=")
    //
    //                    }
    //                    .listStyle(.plain)
                        
                        
                        if searchedText.isEmpty {
                            List{
                                ForEach(selectedDrug) { drug in
                                    Text("\(drug.brandName) - \(Int(drug.price))/=")
                                }
                                .onDelete { indexSet in
                                    selectedDrug.remove(atOffsets:  indexSet)
                                }
                            }
                            .frame(width: 300, height: 200)
                            .listStyle(.plain)
                            
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
                            .frame(width: 300, height: 200)
                            .listStyle(.plain)
                        }
                        
                        
                        
                    }
                    HStack{
                        Text("Total Fee: \(Int(totalFee)) /=")
                    }
                    .font(.title2)
                    
                    
                
                    
                    NavigationLink(destination: DrugInvoiceView(invoice: DrugInvoiceModel(patientName: name, patientContact: contact, orgId: OrgID, drugList: selectedDrug, total: totalFee), orgModel: orgModel, hideButton: false), isActive: $invoiceGenerated) {
                        Button {
                            /*
                             let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                             
                             manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                             
                             */
                            
                            if let patID = patientId {
                                manager.createInvoice(invoice: DrugInvoiceModel(patientName: name, patientId: patID, patientContact: contact, orgId: OrgID, drugList: selectedDrug, total: totalFee))
                            }else {
                                manager.createInvoice(invoice: DrugInvoiceModel(patientName: name, patientContact: contact, orgId: OrgID, drugList: selectedDrug, total: totalFee))
                            }
                            
                          
                            
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
    }
        
    
    
    func isValidContact(_ contact: String) -> Bool {
        let contactRegex = #"^(?:\+88|01)?\d{11}$"#
        let contactPredicate = NSPredicate(format: "SELF MATCHES %@", contactRegex)
        return contactPredicate.evaluate(with: contact)
    }
    
    
}

struct DrugBillView_Previews: PreviewProvider {
    static var previews: some View {
        DrugBillForm( orgModel: OrganizationModel(name: "org", address: "dhaka", contact: "01911232323", type: "hos", email: "ceo@gmail.com", emergencyContact: "0191123232", operatingHour: "23/3", orgCode: "hos"))
    }
}
