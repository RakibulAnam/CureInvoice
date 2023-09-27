//
//  HospitalDetailCellView.swift
//  CareInvoice
//
//  Created by Jotno on 9/13/23.
//

import SwiftUI

struct CellView: View {
    
    var model : Any
    
    var body: some View {
        
        ZStack {
            
            if let orgModel = model as? OrganizationModel{
                VStack {
                    
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
                            
                            
                            Text(orgModel.name)
                                .font(.title2)
                            
                            Text(orgModel.address)
                                .foregroundColor(.black)
                                .font(.subheadline)
                            
                        }
                        .layoutPriority(1)//: VSTACK
                        Spacer()
                    }//: HSTACK
                    .padding()
                    
                    Divider()
                    
                }//: VStack
            } else
            if let orgAdminModel = model as? OrgAdminModel{
                VStack {
                    
                    HStack(spacing: 10){
                        
                        
                        Image("orgAdmin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("Symboltint").opacity(0.3), lineWidth: 2)
                            )
                            .padding(1)
                        
                        
                        
                        VStack(alignment: .leading, spacing: 3){
                            
                            
                            Text(orgAdminModel.name)
                                .font(.title2)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(orgAdminModel.contact)
                                Text(orgAdminModel.email)
                                
                            }
                            .foregroundColor(.black)
                            .font(.footnote)
                            
                            
                        }
                        .frame(height: 60)
                        .layoutPriority(1)//: VSTACK
                        Spacer()
                    }//: HSTACK
                    .padding()
                    
                   
                    
                }//: VStack
            }
            else
            if let adminModel = model as? AdminModel{
                VStack {
                    
                    HStack(spacing: 10){
                        
                        
                        Image("orgAdmin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("Symboltint").opacity(0.3), lineWidth: 2)
                            )
                            .padding(1)
                        
                        
                        
                        VStack(alignment: .leading, spacing: 3){
                            
                            
                            Text(adminModel.name)
                                .font(.title2)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(adminModel.contact)
                                Text(adminModel.email)
                                
                            }
                            .foregroundColor(.black)
                            .font(.footnote)
                            
                            
                        }
                        .frame(height: 60)
                        .layoutPriority(1)//: VSTACK
                        Spacer()
                    }//: HSTACK
                    .padding()
                    
                   
                    
                }//: VStack
            }
            
            
            
            
            
            
            
        }//: Zstack
        
    }
}

struct HospitalCellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(model: OrgAdminModel(name: "Rohid", username: "roro", password: "123456", email: "rohid@gmail.com", contact: "01911362438", orgId: 1))
            .previewLayout(.sizeThatFits)
       
    }
    
}
