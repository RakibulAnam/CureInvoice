//
//  AppointmentFormView.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct AppointmentFormView: View {
    
    
    @State var name = ""
    @State var email = ""
    @State var contact = ""
    @State var fee = ""
    @State var discount = ""
    
    @State var searchedPatient = ""
    
    @State var patientId : Int?
    @State var isValid : Bool = true
    
    @StateObject var orgManager = OrganizationManager()
    
    var totalFee : Double {
        var total = (Double(docModel.consultation) ?? 0.0) - (Double(discount) ?? 0.0)
        
        
        return total
    }
    
    @State var invoiceGenerated : Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    let slots = ["Morning - 10AM", "Evening - 3PM", "Night - 9PM"]
   
    @State private var selectedSlot = ""
    
    
    @AppStorage("OrgID") var OrgID : Int = 0
    @StateObject var manager = HospitalManager()
    //var spId : Int
    
    var docModel : DoctorModel
    @State var showAlert = false
    @State var errorText = ""
    
 
    
    var body: some View {
        
        ZStack {
            
            ScrollView {
                VStack(alignment: .leading, spacing: 5){
                    
    //                Text("Make Appointment")
    //                    .font(.title)
                    
                    
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
                    
                    
                        
                        
                        
                        
    //                    FormTextFieldView(title: "Patient Name", bindingText: $name)
    //                    FormTextFieldView(title: "Contact", bindingText: $contact, validate: isValidContact)
                        VStack(alignment: .leading, spacing: 5) {
                            
                          
                            HStack{
                                Text("Select Slot:")
                                    .font(.title3)
                                    .fontWeight(.light)
                                Spacer()
                            
                            }
                            .padding(.vertical, 5)
                            .padding(.top)
                            
                            
                            List{
                                ForEach(docModel.doctorSlotDTOList) { item in
                                    Text("\(item.day) - \(item.time)")
                                        .listRowInsets(EdgeInsets())
                                        .onTapGesture {
                                            selectedSlot = "\(item.day) - \(item.time)"
                                        }
                                }
                            }
                            .environment(\.editMode, .constant(.active))
                            .frame(width: 300, height: 100)
                            .listStyle(.plain)
                            
                            Text(selectedSlot)
                                .foregroundColor(.black)
                                .font(.title3)
                                .fontWeight(.regular)
                                .padding(.vertical)
                            
    //                        Picker("Morning - 10AM", selection: $selectedSlot) {
    //                            ForEach(docModel.doctorSlotDTOList, id: \.id) { slot in
    //                                Text("\(slot.day) - \(slot.time)").tag(Optional<String>(nil))
    //                                      }
    //                                  }
    //                        .frame(width: 350)
    //                                  .pickerStyle(MenuPickerStyle())
    //                                  .padding(10)
    //                                  .background(
    //                                  RoundedRectangle(cornerRadius: 8)
    //                                    .stroke()
    //                                  )

                                      
                                  
                        }//:Vstack
                    
                       // FormTextFieldView(title: "Consultation Fee", bindingText: $fee)
                    
                        
                    Text("Consultation Fee : \(docModel.consultation)")
                        .font(.title3)
                        .fontWeight(.light)
                        .padding(.vertical)
                    Text("Follow-Up Fee : \(docModel.followUp)")
                        .font(.title3)
                        .fontWeight(.light)
                        .padding(.vertical)
                    
                       // FormTextFieldView(title: "Discount", bindingText: $discount)
                       
                    VStack(alignment: .leading , spacing: 5){
                        Text("Discount")
                            .font(.title3)
                            .fontWeight(.light)
                        TextField("", text: $discount)
                            .onChange(of: discount, perform: { newValue in
                                
                                    isValid = isValidDiscount(newValue)
                                
                            })
                            .padding(10)
                            .textInputAutocapitalization(.never)
                            .font(.title3)
                            .fontWeight(.light)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color(.gray), lineWidth: 1)) // Apply a rounded border
                        
                        if !isValid {
                            Text("Discount Must Be Less than MaxDiscount : \(docModel.maxDiscount)")
                                        .foregroundColor(.red)
                                        
                                }
                    }//:Vstack
                    .padding(.top, 20)
                    .padding(.horizontal, 3)
                    
                    
                    
                    
                    
                    
                    
                    
                        
                        
//                        HStack {
//                            Text("Total : \(Int(totalFee))")
//                                .font(.title)
//                        }.padding(.top)
                       
                        
                    if let orgModel = orgManager.orgModel {
                        NavigationLink(destination: AppointmentInvoiceView(invoice: AppointmentInvoiceModel(patientName: name, orgId: OrgID, patientContact: contact, doc_name: docModel.name, doc_id: docModel.id!, slot: selectedSlot, consultationFee: docModel.consultation, discount: discount, totalFees: totalFee), orgModel: orgModel), isActive: $invoiceGenerated) {
                            if isValid {
                                Button {
                                    /*
                                    let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                                    
                                    manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                                     
                                    */
                                    
                                    if let patID = patientId {
                                        manager.makeAppointment(invoice: AppointmentInvoiceModel( patientName: name, orgId: OrgID, patientContact: contact, patientId: patID, doc_name: docModel.name, doc_id: docModel.id!, slot: selectedSlot, consultationFee: docModel.consultation, discount: discount, totalFees: totalFee), completion: { error in
                                            
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
                                        let newAppoint = AppointmentInvoiceModel(patientName: name, orgId: OrgID, patientContact: contact, doc_name: docModel.name, doc_id: docModel.id!, slot: selectedSlot, consultationFee: docModel.consultation, discount: discount, totalFees: totalFee)
                                        manager.makeAppointment(invoice: newAppoint, completion: { error in
                                            
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
                                    Text("book".uppercased())
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
                            }
                            
                        }
                    }
                    
                       
                        
                       
                        
                        
                       
                        
                                    
                } //: VSTACK
                .padding()
            }
            
            
            
            
            
            
        }//: ZSTACK
        .onAppear{
//            manager.getDoctors(orgID: OrgID, specialityID: spId)
            orgManager.getSingleOrganization(from: K.GET_ORGANIZATION_BY_ID, for: OrgID)
        }
        
        
    }
    
    func isValidDiscount(_ discount: String) -> Bool {
        
        if Int(discount) ?? 0 > Int(docModel.maxDiscount)! {
            return false
        }else {
            return true
        }
        
        
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

struct AppointmentFormView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentFormView(docModel: DoctorModel(id: 1, name: "Rohid", degrees: "msc", contact: "10123233", email: "edsd", followUp: "400", consultation: "200", minDiscount: "100", maxDiscount: "200", doctorSlotDTOList: [Slot(day: "Monday", time: "12")], orgId: [1], spId: [1]))
    }
}
