//
//  InvestigationCell.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct InvestigationCell: View {
    
    var investigation : InvestigationModel
    
    var body: some View {
        VStack {
            HStack(spacing: 20){
                
                Image("health-service")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60, alignment: .leading)
                
                
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(investigation.serviceName)
                        .font(.title2)
                        .fontWeight(.light)
                    
                    
                    Text("\(Int(investigation.serviceCharge)) /=")
                        .font(.title2)
                        .fontWeight(.light)
                    
                }
                .frame(height: 60)
                .layoutPriority(1)
                
                Spacer()
            }
            .padding()
            
            Divider()
        }//:VSTACK
    }
}

struct InvestigationCell_Previews: PreviewProvider {
    static var previews: some View {
        InvestigationCell(investigation: InvestigationModel(serviceName: "Investigation Name", serviceCharge: 220.0))
            .previewLayout(.sizeThatFits)
    }
}
