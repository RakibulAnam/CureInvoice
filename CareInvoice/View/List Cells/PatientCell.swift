//
//  PatientCell.swift
//  CareInvoice
//
//  Created by Jotno on 10/4/23.
//

import SwiftUI

struct PatientCell: View {
    
    var patModel : PatientModel
    
    var body: some View {
        HStack{
            Text(patModel.name)
                .font(.title2)
                .fontWeight(.light)
            Spacer()
        }
        .padding(5)
    
       
    }
}

struct PatientCell_Previews: PreviewProvider {
    static var previews: some View {
        PatientCell(patModel: PatientModel(name: "Rohid", contact: "01911362438", orgId: 1))
            .previewLayout(.sizeThatFits)
    }
}
