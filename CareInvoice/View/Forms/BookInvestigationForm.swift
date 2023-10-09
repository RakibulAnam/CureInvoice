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
    @State var orgModel : OrganizationModel
 
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
    @State var searchedPatient = ""
    @State var patientId : Int?
    
    @StateObject var manager = DiagnosticCenterManager()
    
    @State var selectedInvestigation : [InvestigationModel] = []
    
    @AppStorage("OrgID") var OrgID : Int = 0
    
    @State var showAlert = false
    @State var errorText = ""
    
    var body: some View {
        
        
        ZStack {
            
            ScrollView {
                VStack(alignment: .leading){
                    
                    Text("Investigation Bill")
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
                    }.ignoresSafeArea(.keyboard, edges: .bottom)
                    
                    
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
                    
                    Text("Select Investigation")
                        .font(.title)
                        .padding(.top)
                    
                    TextField("Enter Investigation Name", text: $searchedText)
                        .onChange(of: searchedText, perform: { newValue in
                            if newValue == ""{
                                manager.getInvestigationByName(orgId: OrgID, name: "1")
                            }
                            manager.getInvestigationByName(orgId: OrgID, name: newValue)
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
                        .frame(width: 300, height: 200)
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
                            .frame(width: 300, height: 200)
                            .listStyle(.plain)
                        }
                        
                        
                        
                    }
                    HStack{
                        Text("Total Fee: \(Int(totalFee)) /=")
                    }
                    .font(.title2)
                    
                    
                
                    
                    NavigationLink(destination: InvestigationInvoiceView(invoice: InvestigationInvoiceModel(p_name: name, contact: contact, org_id: OrgID, investigationList: selectedInvestigation, total: Double(totalFee)), orgModel: orgModel), isActive: $invoiceGenerated) {
                        Button {
                            /*
                             let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                             
                             manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                             
                             */
                            
                            /*
                            manager.createInvoice(invoice: DrugInvoiceModel(patientName: name, patientContact: contact, orgId: OrgID, drugList: selectedDrug, total: totalFee))
                            */
                            
                            
                            if let patID = patientId {
                                manager.bookInvestigation(invoice: InvestigationInvoiceModel( p_name: name, pid: patID, contact: contact, org_id: OrgID, investigationList: selectedInvestigation, total: Double(totalFee)), completion: { error in
                                    
                                    switch error {
                                    case .urlProblem :
                                        errorText = "There Was a Problem Reaching the Server"
                                        showAlert = true
                                    
                                    case .duplicateData:
                                        errorText = "The Email and Org Code Must be unique, please try again"
                                        showAlert = true
                                        
                                    case nil :
                                        print("Success")
                                        invoiceGenerated = true
                                       
                                    
                                    case .some(.emptyTextField):
                                        errorText = "Please Enter All Information"
                                        showAlert = true
                                    }
                                    
                                })
                            }else {
                                manager.bookInvestigation(invoice: InvestigationInvoiceModel(p_name: name, contact: contact, org_id: OrgID, investigationList: selectedInvestigation, total: Double(totalFee)), completion: { error in
                                    
                                    switch error {
                                    case .urlProblem :
                                        errorText = "There Was a Problem Reaching the Server"
                                        showAlert = true
                                    
                                    case .duplicateData:
                                        errorText = "The Email and Org Code Must be unique, please try again"
                                        showAlert = true
                                        
                                    case nil :
                                        print("Success")
                                        invoiceGenerated = true
                                       
                                    
                                    case .some(.emptyTextField):
                                        errorText = "Please Enter All Information"
                                        showAlert = true
                                    }
                                    
                                })
                            }
                            
                            
                            
                           // invoiceGenerated = true
                            
                            
                            
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
                        .alert(errorText, isPresented: $showAlert){
                            Button("OK", role: .cancel) {
                                
                            }
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





struct BookInvestigationForm_Previews: PreviewProvider {
    static var previews: some View {
        BookInvestigationForm( orgModel: OrganizationModel(name: "org", address: "dhaka", contact: "01911232323", type: "hos", email: "ceo@gmail.com", emergencyContact: "0191123232", operatingHour: "23/3", orgCode: "hos"))
    }
}
