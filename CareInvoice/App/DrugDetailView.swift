//
//  DrugDetailView.swift
//  CareInvoice
//
//  Created by Jotno on 9/26/23.
//

import SwiftUI

struct DrugDetailView: View {
    
    var drugModel : DrugModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            
            VStack{
                Image(systemName: "pill")
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .scaledToFit()
                
                Text(drugModel.brandName)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("PrimaryColor"))
                
                Text(drugModel.strengthName)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                
                Text("Price: \("\(drugModel.price)")")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
            
            
            
            
            
            VStack(alignment: .leading, spacing: 5){
                Text("Generic: \(drugModel.genericName)")
                
                Text("Formation: \(drugModel.formationName)")
                
                
                
                Text("Vendor: \(drugModel.vendorName)")
                
            }
            .padding()
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
                    .foregroundColor(Color("Symboltint"))
            )
        }
    }
}

struct DrugDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DrugDetailView(drugModel: DrugModel(id: 1, brandName: "Barium Sulfate", price: 200.0, vendorName: "AD-DIN PHARMA", genericName: "ACEMETACIN", formationName: "INHALER", strengthName: "(1gm+500mg)/100ml"))
    }
}
