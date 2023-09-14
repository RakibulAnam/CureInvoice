//
//  HospitalDetailCellView.swift
//  CareInvoice
//
//  Created by Jotno on 9/13/23.
//

import SwiftUI

struct CellView: View {
    
    var model : OrganizationModel
    
    var body: some View {
        
        ZStack {
            
            
            
            
            VStack {
                
                //                Divider()
                //                    .frame(width: .infinity, height: 2, alignment: .center)
                
                HStack(spacing: 10){
                    
                    
                    Image("hospital")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("Symboltint").opacity(0.3), lineWidth: 2)
                        )
                        .padding(1)
                    
                    
                    VStack(alignment: .leading, spacing: 10){
                        
                        
                        Text(model.name)
                            .font(.title2)
                        Text(model.address)
                            .foregroundColor(Color("Symboltint"))
                            .font(.subheadline)
                        
                        //                    if let hospital = model as? HospitalModel {
                        //
                        //                    } else if let chamber = model as? ChamberModel {
                        //                        Text(chamber.name)
                        //                            .font(.title2)
                        //                        Text(chamber.address)
                        //                            .foregroundColor(Color("Symboltint"))
                        //                            .font(.subheadline)
                        //                    }
                        
                        
                        
                    }
                    .layoutPriority(1)//: VSTACK
                    Spacer()
                }//: HSTACK
                .padding()
                
                Divider()
                   
            }//: VStack
            
            
            
            
            
            
        }//: Zstack
        
    }
}

struct HospitalCellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(model: OrganizationModel(name: "Ibne Sinha", address: "Dhaka", contact: "01677397270", type: "Hospital", email: "ibne@gmail.com", emergencyContact: "01911362438", operatingHour: "9 AM - 5 PM"))
            .previewLayout(.sizeThatFits)
    }
    
}
