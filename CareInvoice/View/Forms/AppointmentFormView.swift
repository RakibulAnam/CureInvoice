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
    
    var totalFee : Double {
        var total = (Double(fee) ?? 0.0) - (Double(discount) ?? 0.0)
        
        
        
        return total
    }
    
    @State var invoiceGenerated : Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    let doctorNames = ["Dr. Smith", "Dr. Johnson", "Dr. Williams", "Dr. Brown", "Dr. Jones"]
    let slots = ["Morning - 10AM", "Evening - 3PM", "Night - 9PM"]
    @State private var selectedDoctor = "Dr. Smith"
    @State private var selectedSlot = "Morning - 10AM"
    
    
    var body: some View {
        
        ZStack {
            
            VStack(alignment: .leading, spacing: 5){
                
                Text("Make Appointment")
                    .font(.title)
                
                ScrollView(showsIndicators: false){
                    
                    
                    
                    
                    FormTextFieldView(title: "Patient Name", bindingText: $name)
                    FormTextFieldView(title: "Contact", bindingText: $contact, validate: isValidContact)
                    VStack(alignment: .leading, spacing: 5) {
                        
                        HStack{
                            Text("Select Doctor")
                                .font(.title3)
                                .fontWeight(.light)
                            Spacer()
                        }
                        .padding(.vertical, 5)
                        .padding(.top)
                        
                        Picker("Dr. Smith", selection: $selectedDoctor) {
                                      ForEach(doctorNames, id: \.self) { doctorName in
                                          Text(doctorName)
                                              .foregroundColor(.black)
                                      }
                                  }
                        .frame(width: 350)
                                  .pickerStyle(MenuPickerStyle())
                                  .padding(10)
                                  .background(
                                  RoundedRectangle(cornerRadius: 8)
                                    .stroke()
                                  )
                        
                        HStack{
                            Text("Select Slot")
                                .font(.title3)
                                .fontWeight(.light)
                            Spacer()
                        }
                        .padding(.vertical, 5)
                        .padding(.top)
                        
                        Picker("Morning - 10AM", selection: $selectedSlot) {
                                      ForEach(slots, id: \.self) { doctorName in
                                          Text(doctorName)
                                              .foregroundColor(.black)
                                      }
                                  }
                        .frame(width: 350)
                                  .pickerStyle(MenuPickerStyle())
                                  .padding(10)
                                  .background(
                                  RoundedRectangle(cornerRadius: 8)
                                    .stroke()
                                  )

                                  
                              
                    }//:Vstack
                    FormTextFieldView(title: "Consultation Fee", bindingText: $fee)
                    FormTextFieldView(title: "Discount", bindingText: $discount)
                    
                    
                    HStack {
                        Text("Total : \(Int(totalFee))")
                    }
                   
                    
                    NavigationLink(destination: AppointmentInvoiceView(invoice: AppointmentInvoiceModel(patientName: name, patientContact: contact, docor: selectedDoctor, slot: selectedSlot, ConsultationFee: fee, Discount: discount, total: totalFee)), isActive: $invoiceGenerated) {
                        Button {
                            /*
                            let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                            
                            manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                             
                            */
                            
                            let newAppoint = AppointmentInvoiceModel(patientName: name, patientContact: contact, docor: selectedDoctor, slot: selectedSlot, ConsultationFee: fee, Discount: discount, total: totalFee)
                            
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
                    
                   
                    
                    
                   
                    
                }//: SCROLL
                
            } //: VSTACK
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            
            
            
        }//: ZSTACK
        
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
        AppointmentFormView()
    }
}
