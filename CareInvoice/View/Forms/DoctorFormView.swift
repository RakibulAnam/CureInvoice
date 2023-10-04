//
//  DoctorFormView.swift
//  CareInvoice
//
//  Created by Jotno on 9/25/23.
//

import SwiftUI

struct DoctorFormView: View {
    
    @State var name = ""
    @State var email = ""
    @State var contact = ""
    @State var degree = ""
    @State var followUpFee = ""
    @State var consultaionFee = ""
    @State var minimumDiscount = ""
    @State var maximumDiscount = ""
    //@State var slots : [Slot] = []
    let day = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    let times = ["Morning", "Evening", "Night"]
    @State private var selectedDay = "Sunday"
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var speciality : SpecialityListModel
    
    @StateObject var manager = HospitalManager()
    
    
    var body: some View {
        
        ZStack {
            
           
            
            VStack(alignment: .leading){
                
                Text("Add Doctor")
                    .font(.title)
                
                ScrollView(showsIndicators: false){
                    
                    
                    
                    FormTextFieldView(title: "Doctor Name", bindingText: $name)
                    FormTextFieldView(title: "Email", bindingText: $email, validate: isValidEmail)
                    FormTextFieldView(title: "Contact", bindingText: $contact, validate: isValidContact)
                    FormTextFieldView(title: "Degrees", bindingText: $degree)
                    FormTextFieldView(title: "Follow-Up Fee", bindingText: $followUpFee)
                    FormTextFieldView(title: "Consultation Fee", bindingText: $consultaionFee)
                    
                    HStack {
                        FormTextFieldView(title: "Minimum Discount", bindingText: $minimumDiscount)
                        FormTextFieldView(title: "Maximum Discount", bindingText: $maximumDiscount)
                    }
                    
                    HStack {
                        Text("Slots")
                            .font(.title)
                        Spacer()
                    }
                    
                    VStack {
                        
                        VStack (spacing: 5){
                            
                            HStack{
                                Text("Select Day")
                                    .font(.title3)
                                    .fontWeight(.light)
                                Spacer()
                            }
                            
                            
                            Picker("Select a Doctor", selection: $selectedDay) {
                                          ForEach(day, id: \.self) { time in
                                              Text(time)
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
                        }
                        
                        VStack (spacing: 5){
                            
                            HStack{
                                Text("Select Time")
                                    .font(.title3)
                                    .fontWeight(.light)
                                Spacer()
                            }
                            
                            HStack {
                                DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    
                                Text("-")
                                DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                
                                
                               
                            }
                                
                            
                            
                            
                        
                        }// Vstack
                        
                    }
                        
                    
                    
                    
                    
                    
                    Button {
                        /*
                        let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                        
                        manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                         
                        */
                        
                        let newDoctor = DoctorModel(name: name, degrees: degree, contact: contact, email: email, followUp: followUpFee, consultation: consultaionFee, minDiscount: minimumDiscount, maxDiscount: maximumDiscount, doctorSlotDTOList: [Slot(day: selectedDay, time: "\(startTime) - \(endTime)")], orgId: [OrgID], spId: [speciality.id!])
                        
                        manager.createDoctor(doctor: newDoctor, orgId: OrgID)
                      
                        self.presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Text("Add".uppercased())
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




struct DoctorFormView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorFormView(speciality: SpecialityListModel(id: 1, medSpecName: "Heloo", iconUrl: "Hello"))
    }
}
