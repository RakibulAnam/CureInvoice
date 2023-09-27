//
//  SearchedDrugCell.swift
//  CareInvoice
//
//  Created by Jotno on 9/27/23.
//

import SwiftUI

struct SearchedDrugCell: View {
    
    var drugModel : DrugModel
    
    var body: some View {
        VStack {
            HStack(spacing: 20){
                
               
                
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(drugModel.brandName)
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    Text(drugModel.strengthName)
                    
                    Text(drugModel.genericName)
                    
                    Text(drugModel.vendorName)
                    
                    Text("\(Int(drugModel.price))")
                    
                    
                }
                .font(.caption)
                
                Spacer()
                
                
            }
            .padding()
            
            Divider()
        }//:VSTACK
    }
}

struct SearchedDrugCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchedDrugCell(drugModel: DrugModel(id: 1, brandName: "Barium Sulfate", price: 200.0, vendorName: "AD-DIN PHARMA", genericName: "ACEMETACIN", formationName: "INHALER", strengthName: "(1gm+500mg)/100ml"))
    }
}
