//
//  InvestigationCell.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct InvestigationCell: View {
    
    var service : ServiceModel
    
    var body: some View {
        VStack {
            HStack(spacing: 20){
                
                Image("health-service")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60, alignment: .leading)
                
                
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(service.serviceName)
                        .font(.title2)
                        .fontWeight(.light)
                    
                    
                    Text("\(service.serviceCharge) /=")
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
        InvestigationCell(service: ServiceModel(serviceName: "Autopsy", serviceCharge: "5500"))
            .previewLayout(.sizeThatFits)
    }
}
