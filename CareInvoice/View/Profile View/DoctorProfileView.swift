//
//  DoctorProfileView.swift
//  CareInvoice
//
//  Created by Jotno on 10/3/23.
//

import SwiftUI

struct DoctorProfileView: View {
    
    var docModel : DoctorModel
    @State var speciality : SpecialityListModel
    @StateObject var manager = HospitalManager()
    @AppStorage("ROLE") var userRole : String = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20){
                
                
                if userRole == K.Role.ORG_ADMIN{
                    HStack {
                        
                        
                        
                        Spacer()
                        NavigationLink(destination: DoctorFormView(speciality: speciality, profile: docModel)) {
                            Image(systemName: "pencil")
                        }
                        
                    }
                }
               
                
                VStack{
                    Image("doc3")
                        .resizable()
                        .scaledToFit()
                    
                    Text(manager.doctorModel?.name ?? docModel.name)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("PrimaryColor"))
                    
                    Text(manager.doctorModel?.degrees ?? docModel.degrees)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                   
                    
                }
                
                
                
                
                
                VStack(alignment: .leading, spacing: 5){
                    Text("Contact: \(manager.doctorModel?.contact ?? docModel.contact)")
                    
                    Text("Email: \(manager.doctorModel?.email ?? docModel.email)")
                    
                    Text("Consultation Fee: \(manager.doctorModel?.consultation ?? docModel.consultation)")
                    
                    Text("Follow Up Fee: \(manager.doctorModel?.followUp ?? docModel.followUp)")
                    Text("Slots: ")
                    ForEach(manager.doctorModel?.doctorSlotDTOList ?? docModel.doctorSlotDTOList) { slot in
                        Text("\(slot.day) - \(slot.time)")
                    }
                }
                .padding()
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1)
                        .foregroundColor(Color("Symboltint"))
                )
                
              
                
                Spacer()
                
                NavigationLink(destination: AppointmentFormView(docModel: manager.doctorModel ?? docModel)) {
                    Text("Make Appointment".uppercased())
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 60, alignment: .center)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(10)
                        .padding(.vertical)
                }
                
            }//Vstack
            .padding()
        }//:Zstack
        .onAppear{
            manager.getDoctorProfile(docID: docModel.id!)
        }
    }
}

struct DoctorProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorProfileView(docModel: DoctorModel(name: "Rohid", degrees: "msc", contact: "10123233", email: "edsd", followUp: "400", consultation: "200", minDiscount: "100", maxDiscount: "200", doctorSlotDTOList: [Slot(day: "Monday", time: "12")], orgId: [1], spId: [1]), speciality: SpecialityListModel(medSpecName: "Dinner", iconUrl: ""))
    }
}
