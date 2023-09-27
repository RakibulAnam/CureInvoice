//
//  DrugCell.swift
//  CareInvoice
//
//  Created by Jotno on 9/26/23.
//

import SwiftUI

struct DrugCell: View {
    
    var drugModel : DrugModel
    
    var body: some View {
        VStack {
            HStack(spacing: 20){
                
                Image(systemName: "pills.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .leading)
                
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(drugModel.brandName)
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    Text(drugModel.strengthName)
                    
                    Text(drugModel.genericName)
                    
                    Text(drugModel.vendorName)
                    
                    
                }
                .font(.caption)
                
                Spacer()
                
                
            }
            .padding()
            
            Divider()
        }//:VSTACK
    }
}

struct DrugCell_Previews: PreviewProvider {
    static var previews: some View {
        DrugCell(drugModel: DrugModel(id: 1, brandName: "Barium Sulfate", price: 200.0, vendorName: "AD-DIN PHARMA", genericName: "ACEMETACIN", formationName: "INHALER", strengthName: "(1gm+500mg)/100ml"))
            .previewLayout(.sizeThatFits)
    }
}
