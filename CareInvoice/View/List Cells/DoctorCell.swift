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
                
                
                
                Text(docModel.doctorName)
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
        DoctorCell(docModel: DoctorModel(id: 1, doctorName: "Pritom", doctorDegree: "MBBS"))
            .previewLayout(.sizeThatFits)
    }
}
