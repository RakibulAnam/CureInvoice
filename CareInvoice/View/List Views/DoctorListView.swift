//
//  DoctorListView.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct DoctorListView: View {
    
    @StateObject var manager = HospitalManager()
    @AppStorage("OrgID") var OrgID : Int = 0
    @State var speciality : SpecialityListModel
    
    @AppStorage("ROLE") var userRole : String = ""
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 10) {
                
                Text("Doctors")
                    .font(.title)
                    .padding()
//                HStack{
//                    Spacer()
//                    
//                    NavigationLink(destination: AppointmentFormView(spId: speciality.id!)) {
//                        Text("Make Appointment")                             }
//                    
//                }
//                .padding()
                
                List {
                    ForEach(manager.doctorList) { doctor in
                        
                        NavigationLink(destination: DoctorProfileView(docModel: doctor, speciality: speciality)) {
                            DoctorCell(docModel: doctor)
                        }
                        
                       
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }//: VSTACK
            .onAppear {
                manager.getDoctors(orgID: OrgID, specialityID: speciality.id ?? 1)
            }
            
            if userRole == K.Role.ORG_ADMIN {
                NavigationLink(destination: DoctorFormView(speciality: speciality).navigationBarTitleDisplayMode(.inline)) {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color("PrimaryColor"))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                }.padding() //: FLOATING BUTTON
            }
            
      
            
            
        }//: ZSTACK
        
        
    }
}

struct DoctorListView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorListView(speciality: SpecialityListModel(id: 1, medSpecName: "SomeThing", iconUrl: "SomeTing"))
    }
}
