//
//  RevenueView.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import SwiftUI

struct RevenueView: View {
    var body: some View {
        
        
       
        
        
        
        
        VStack {
        
            
            Spacer()
            
            VStack(spacing: 10) {
                Text("Total Income")
                    .font(.title2)
                Text("$36000.00")
                    .font(.largeTitle)
                    .foregroundColor(Color("PrimaryColor"))
                Text("Consultation Revenue")
                    .font(.title3)
            }
            .padding()
            .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("CardBackground"))
                .frame(maxWidth: .infinity)
            )
            .padding()
            
            
            
            VStack(spacing: 10) {
                Text("Total Income")
                    .font(.title2)
                Text("$36000.00")
                    .font(.largeTitle)
                    .foregroundColor(Color("PrimaryColor"))
                Text("Investigation Revenue")
                    .font(.title3)
            }
            .padding()
            .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("CardBackground"))
                .frame(maxWidth: .infinity)
            )
            .padding()
            
            Spacer()
            
        }//MAIN VSTACK
        
         
    }
}

struct RevenueView_Previews: PreviewProvider {
    static var previews: some View {
        RevenueView()
    }
}
