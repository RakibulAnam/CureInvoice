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
                
                Image(systemName: "ivfluid.bag")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 60, height: 60, alignment: .leading)
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color("Symboltint").opacity(0.3), lineWidth: 2)
//                    )
//                    .padding(1)
                
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(investigation.serviceName)
                        .font(.title2)
                        .fontWeight(.regular)
                    
                    
                    Text("Tk. \(Int(investigation.serviceCharge))")
                        .font(.title3)
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
