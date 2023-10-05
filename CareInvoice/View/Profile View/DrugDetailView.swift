//
//  DrugDetailView.swift
//  CareInvoice
//
//  Created by Jotno on 9/26/23.
//

import SwiftUI

struct DrugDetailView: View {
    
    var drugModel : DrugModel
    @AppStorage("ROLE") var userRole : String = ""
    
    var body: some View {
        ZStack (alignment: .bottomTrailing){
                
                VStack {
                    
                    
                    HStack{
                        Spacer()
                        NavigationLink(destination: OrgDrugEditForm(drugModel: drugModel)) {
                            Text("Edit Price and Quantity")
                                .padding()
                                .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke()
                                )
                                .padding()
                        }
                        
                    }
                    Spacer()
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
                        
                        if userRole != K.Role.ROOT {
                            Text("Quantity: \(drugModel.quantity ?? 0)")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                        }
                        
                        
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
                    
                    Spacer()
                    
                }
            
            
            if userRole == "ROLE_ROOT" {
                NavigationLink(destination: AddDrugForm(profile: drugModel)) {
                    Image(systemName: "pencil")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color("PrimaryColor"))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                }.padding() //: FLOATING BUTTON
            }
            
         
            
                
            
            
            
           
            
        }
        
    }
}

struct DrugDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DrugDetailView(drugModel: DrugModel(id: 1, brandName: "Barium Sulfate", price: 200.0, vendorName: "AD-DIN PHARMA", genericName: "ACEMETACIN", formationName: "INHALER", strengthName: "(1gm+500mg)/100ml"))
    }
}