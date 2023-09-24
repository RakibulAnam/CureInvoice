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
                
                
                
                Text(model.medSpecName)
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

struct SpecialityCell_Previews: PreviewProvider {
    static var previews: some View {
        SpecialityCell(model: SpecialityListModel(medSpecName: "Radiology", iconUrl: "ent.png"))
            .previewLayout(.sizeThatFits)
    }
}
