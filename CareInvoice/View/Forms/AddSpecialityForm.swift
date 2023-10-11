//
//  AddSpecialityForm.swift
//  CareInvoice
//
//  Created by Jotno on 10/3/23.
//

import SwiftUI

struct AddSpecialityForm: View {
    
    @State var medSpecName : String = ""
    @StateObject var manager = OrganizationManager()
    
    var profile : SpecialityListModel?
    
    @State var title = "Add Speciality"
    @State var buttonName = "Add"
    @State var allFilled : Bool = true
    
    @State var errorText = ""
    @State var showAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    
    
    init(profile : SpecialityListModel? = nil){
        self.profile = profile
        
        if let org = profile {
            self._medSpecName = State(initialValue: org.medSpecName)
            self._title = State(initialValue: String("Edit Speciality"))
            self._buttonName = State(initialValue: String("Update"))
        }
    }
    
    var body: some View {
        ZStack {
        
            VStack(alignment: .leading){
                
                Text(title)
                    .font(.title)
                
                ScrollView(showsIndicators: false){
                    

                    
                    FormTextFieldView(title: "Speciality Name", bindingText: $medSpecName)
                    if allFilled == false {
                        Text("Please Enter all Information")
                            .font(.headline)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    
                    Button {
      
                        
                        if medSpecName.isEmpty {
                            
                            allFilled = false
                            
                        }else {
                            
                            allFilled = true
                            
                            let spec = SpecialityListModel(medSpecName: medSpecName, iconUrl: "stethoscope.png")
                            
                            if let profile = profile {
                                manager.updateSpeciality(speciality: spec, specialityId: profile.id!, completion: {sucess in
                                    switch sucess {
                                    case .duplicate :
                                        print("YES")
                                        errorText = "The Speciality already exists"
                                        showAlert = true
                                    case nil:
                                        DispatchQueue.main.async {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                        print("NO")
                                    }
                                })
                            }else {
                                manager.addSpeciality(speciality: spec, completion: {sucess in
                                    switch sucess {
                                    case .duplicate :
                                        print("YES")
                                        errorText = "The Speciality already exists"
                                        showAlert = true
                                    case nil:
                                        DispatchQueue.main.async {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                        print("NO")
                                    }
                                })
                            }
                            
                           // self.presentationMode.wrappedValue.dismiss()
                        }
                        
                        
                     
                        
                    } label: {
                        Text(buttonName.uppercased())
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
                    
                }//: SCROLL
                
            } //: VSTACK
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            
            
            
        }//: ZSTACK
    }
}

struct AddSpecialityForm_Previews: PreviewProvider {
    static var previews: some View {
        AddSpecialityForm()
    }
}
