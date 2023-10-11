//
//  DrugDetailView.swift
//  CareInvoice
//
//  Created by Jotno on 9/26/23.
//

import SwiftUI

struct DrugDetailView: View {
    
    var drugModel : DrugModel
    @StateObject var manager = Pharmacymanager()
    @AppStorage("ROLE") var userRole : String = ""
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var body: some View {
        
        
        if userRole == K.Role.ORG_ADMIN || userRole == K.Role.NORMAL_ADMIN {
            ZStack (alignment: .bottomTrailing){
      
                    VStack {
                        
                        if userRole == K.Role.ORG_ADMIN{
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
                        }
                        
                        Spacer()
                        VStack{
                            
                            
                            Image(systemName: "pill")
                                .resizable()
                                .frame(width: 150, height: 150, alignment: .center)
                                .scaledToFit()
                            
                            Text(manager.drugModel?.brandName ?? drugModel.brandName)
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(Color("PrimaryColor"))
                            
                            Text(manager.drugModel?.strengthName ?? drugModel.strengthName)
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                            
                            Text("Price: \("\(manager.drugModel?.price ?? drugModel.price)")")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                            
                            
                                Text("Quantity: \(manager.drugModel?.quantity ?? drugModel.quantity ?? 0)")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .foregroundColor(.secondary)
   
                        }
                        
                        
                        
                        
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("Generic: \(manager.drugModel?.genericName ?? drugModel.genericName)")
                            
                            Text("Formation: \(manager.drugModel?.formationName ?? drugModel.formationName)")
                            
                            
                            
                            Text("Vendor: \(manager.drugModel?.vendorName ?? drugModel.vendorName)")
                            
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
                

            }
            .onAppear{
                manager.getDrugProfile(drugId: drugModel.id!, orgId: OrgID)
            }
        }
        else {
            ZStack (alignment: .bottomTrailing){
                    
                
                
                
                    VStack {
                        
//                        if userRole == K.Role.ORG_ADMIN{
//                            HStack{
//                                Spacer()
//                                NavigationLink(destination: OrgDrugEditForm(drugModel: drugModel)) {
//                                    Text("Edit Price and Quantity")
//                                        .padding()
//                                        .background(
//                                        RoundedRectangle(cornerRadius: 5)
//                                            .stroke()
//                                        )
//                                        .padding()
//                                }
//
//                            }
//                        }
                        
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
                            
//                            if userRole != K.Role.ROOT {
//                                Text("Quantity: \(drugModel.quantity ?? 0)")
//                                    .font(.title2)
//                                    .fontWeight(.medium)
//                                    .foregroundColor(.secondary)
//                            }
                            
                            
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
