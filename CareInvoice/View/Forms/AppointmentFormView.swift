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
    
    
    
    var totalFee : Double {
        var total = (Double(fee) ?? 0.0) - (Double(discount) ?? 0.0)
        
        
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
    
    
 
    
    var body: some View {
        
        ZStack {
            
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
                }
                
                ZStack{
                    
                    if searchedPatient.isEmpty {
                        VStack{
                            FormTextFieldView(title: "Patient Name", bindingText: $name)
                            
                            FormTextFieldView(title: "Patient Contact", bindingText: $contact, validate: isValidContact)
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
                        .listStyle(.plain)
                        
                    }
                    
                    
                    
                }
                
                
                    
                    
                    
                    
//                    FormTextFieldView(title: "Patient Name", bindingText: $name)
//                    FormTextFieldView(title: "Contact", bindingText: $contact, validate: isValidContact)
                    VStack(alignment: .leading, spacing: 5) {
                        
                      
                        HStack{
                            Text("Select Slot:")
                                .font(.title3)
                                .fontWeight(.light)
                            Spacer()
                            
                            Text(selectedSlot)
                                .font(.title3)
                                .fontWeight(.light)
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
                        .listStyle(.plain)
                        
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
                    FormTextFieldView(title: "Consultation Fee", bindingText: $fee)
                    FormTextFieldView(title: "Discount", bindingText: $discount)
                    
                    
                    HStack {
                        Text("Total : \(Int(totalFee))")
                    }
                   
                    
                    NavigationLink(destination: AppointmentInvoiceView(invoice: AppointmentInvoiceModel(patientName: name, orgId: OrgID, patientContact: contact, doc_name: docModel.name, doc_id: docModel.id!, slot: selectedSlot, consultationFee: fee, discount: discount, totalFees: totalFee)), isActive: $invoiceGenerated) {
                        Button {
                            /*
                            let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                            
                            manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                             
                            */
                            
                            if let patID = patientId {
                                manager.makeAppointment(invoice: AppointmentInvoiceModel( patientName: name, orgId: OrgID, patientContact: contact, patientId: patID, doc_name: docModel.name, doc_id: docModel.id!, slot: selectedSlot, consultationFee: fee, discount: discount, totalFees: totalFee))
                            }else {
                                let newAppoint = AppointmentInvoiceModel(patientName: name, orgId: OrgID, patientContact: contact, doc_name: docModel.name, doc_id: docModel.id!, slot: selectedSlot, consultationFee: fee, discount: discount, totalFees: totalFee)
                                manager.makeAppointment(invoice: newAppoint)
                            }
                            
                           
                            
                            invoiceGenerated = true
                          
                            
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
                    }
                    
                   
                    
                    
                   
                    
                                
            } //: VSTACK
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            
            
            
        }//: ZSTACK
        .onAppear{
//            manager.getDoctors(orgID: OrgID, specialityID: spId)
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
