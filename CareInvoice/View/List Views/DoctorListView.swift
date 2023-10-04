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
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 10) {
                
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
                        
                        NavigationLink(destination: DoctorProfileView(docModel: doctor)) {
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
            
            NavigationLink(destination: DoctorFormView(speciality: speciality).navigationBarTitleDisplayMode(.inline)) {
                Image(systemName: "plus")
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(Color("PrimaryColor"))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4, x: 0, y: 4)
            }.padding() //: FLOATING BUTTON
            
            
        }//: ZSTACK
        
        
    }
}

struct DoctorListView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorListView(speciality: SpecialityListModel(id: 1, medSpecName: "SomeThing", iconUrl: "SomeTing"))
    }
}
