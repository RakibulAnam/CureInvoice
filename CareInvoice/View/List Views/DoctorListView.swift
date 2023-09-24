//
//  DoctorListView.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct DoctorListView: View {
    
    var speciality : SpecialityDetailModel
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 10) {
                
                HStack{
                    Spacer()
                    
                    NavigationLink(destination: EmptyView()) {
                        Text("Make Appointment")                             }
                    
                }
                .padding()
                
                List {
                    ForEach(speciality.doctor) { doctor in
                        DoctorCell(docModel: doctor)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }//: VSTACK
            
            NavigationLink(destination: EmptyView().navigationBarTitleDisplayMode(.inline)) {
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
        DoctorListView(speciality: SpecialityDetailModel(id: 1, doctor: [DoctorModel(id: 1, doctorName: "Nafis", doctorDegree: "MBBS"), DoctorModel(id: 2, doctorName: "Pritom", doctorDegree: "MBBS")], patients: [], services: []))
    }
}
