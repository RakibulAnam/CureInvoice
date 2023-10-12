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
            HStack(spacing: 10){
                
                Image(systemName: "pills.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 60, height: 60, alignment: .leading)
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color("Symboltint").opacity(0.3), lineWidth: 2)
//                    )
//                    .padding(1)
                
                
                VStack(alignment: .leading, spacing: 2) {
                    
                    Text(drugModel.brandName)
                        .font(.title2)
                        .fontWeight(.regular)
                    
//                    Text(drugModel.strengthName)
//                    
//                    Text(drugModel.genericName)
                    
                    Text(drugModel.vendorName)
                        .font(.subheadline)
                    Text("Tk. \(Int(drugModel.price))")
                        .font(.subheadline)
                    Text("Qty. \(drugModel.quantity ?? 0)")
                        .font(.subheadline)
                    
                    
                }
                
                
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
