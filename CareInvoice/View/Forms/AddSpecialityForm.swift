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
                    
                    
                    Button {
                        /*
                        let newAdmin = OrgAdminModel(name: name, username: userName, password: password, email: email.lowercased(), contact: contact)
                        
                        manager.createOrgAdmin(admin: newAdmin, orgID: org.id!)
                         
                        */
                        
                        
                        
//                        if let profile = profile {
//                            manager.updateInvestigation(investigation: newInvestigation, investigationId: profile.id!)
//                        }else {
//                            manager.addInvestigation(investigation: newInvestigation)
//                        }
                        
                        let spec = SpecialityListModel(medSpecName: medSpecName, iconUrl: "stethoscope.png")
                        
                        if let profile = profile {
                            manager.updateSpeciality(speciality: spec, specialityId: profile.id!)
                        }else {
                            manager.addSpeciality(speciality: spec)
                        }
                        
                        
                      
                        self.presentationMode.wrappedValue.dismiss()
                        
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
