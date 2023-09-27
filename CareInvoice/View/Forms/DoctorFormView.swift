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
    @State var slots : [Slot] = []
    let times = ["Morning", "Evening", "Night"]
    @State private var slotDay = ""
    @State private var selectedTime = "Morning"
    
    @Environment(\.presentationMode) var presentationMode
    
    
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
                    FormTextFieldView(title: "Follow-Up Fee", bindingText: $degree)
                    FormTextFieldView(title: "Consultation Fee", bindingText: $degree)
                    
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
                        FormTextFieldView(title: "Day", bindingText: $slotDay)
                        
                        VStack (spacing: 5){
                            
                            HStack{
                                Text("Select Time")
                                    .font(.title3)
                                    .fontWeight(.light)
                                Spacer()
                            }
                            
                            
                            Picker("Select a Doctor", selection: $selectedTime) {
                                          ForEach(times, id: \.self) { time in
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
                        
                    }
                        
                    
                    
                    
                    
                    
                    Button {
                        /*
                        let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                        
                        manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                         
                        */
                      
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


struct Slot {
    var day : String
    var time : String
}

struct DoctorFormView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorFormView()
    }
}
