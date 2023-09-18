//
//  ContentView.swift
//  CareInvoice
//
//  Created by Jotno on 9/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isLoggedIn") var isLoggedIn : Bool = false
    
    var body: some View {
        
        
        ZStack{
            
            if isLoggedIn {
                SuperAdminHomeView()
            } else {
                OnboardingView()
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
