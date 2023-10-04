//
//  DoctorCell.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct DoctorCell: View {
    
    var docModel : DoctorModel
    
    
    var body: some View {
        
        VStack {
            HStack(spacing: 20){
                
                Image("doc3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60, alignment: .leading)
                
                
                
                Text(docModel.name)
                    .font(.title2)
                    .fontWeight(.light)
                    .layoutPriority(1)
                
                Spacer()
            }
            .padding()
            
            Divider()
        }//:VSTACK
        
        
        
    }
}

struct DoctorCell_Previews: PreviewProvider {
    static var previews: some View {
        DoctorCell(docModel: DoctorModel(name: "Rohid", degrees: "msc", contact: "10123233", email: "edsd", followUp: "400", consultation: "200", minDiscount: "100", maxDiscount: "200", doctorSlotDTOList: [Slot(day: "Monday", time: "12")], orgId: [1], spId: [1]))
            .previewLayout(.sizeThatFits)
    }
}
