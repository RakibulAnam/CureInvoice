//
//  SpecialityCell.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct SpecialityCell: View {
    
    
    @State var model : SpecialityListModel
    
    var body: some View {
        
        
        VStack {
            HStack(spacing: 20){
                
                Image(model.iconUrl.replacingOccurrences(of: ".png", with: ""))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("Symboltint").opacity(0.3), lineWidth: 2)
                    )
                    .padding(1)
                
                
                
                Text(model.medSpecName)
                    .font(.title2)
                    .fontWeight(.regular)
                    .layoutPriority(1)
                
                Spacer()
            }
            .padding()
            
            Divider()
        }//:VSTACK
        
    }
}

struct SpecialityCell_Previews: PreviewProvider {
    static var previews: some View {
        SpecialityCell(model: SpecialityListModel(medSpecName: "Radiology", iconUrl: "ent.png"))
            .previewLayout(.sizeThatFits)
    }
}
