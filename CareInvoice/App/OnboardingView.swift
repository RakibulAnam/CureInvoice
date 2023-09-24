//
//  OnboardingView.swift
//  CareInvoice
//
//  Created by Jotno on 9/12/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var userName : String = ""
    @State var password : String = ""
   
    
   @StateObject var loginService = LoginService()
    
    var body: some View {
        
        
            ZStack {
                
                VStack(spacing: 10){

                    Image("hpt-pana")
                        .resizable()
                        .scaledToFit()
                    
                    HStack {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                        Text("CureInvoice")
                            .font(.custom("Cairo-Regular", size: 30))
                        .foregroundColor(.accentColor)
                    }
                    
                    TextField("UserName", text: $userName)
                        .padding()
                        .frame(width: 350, height: 50, alignment: .center)
                        .background(Color("CardBackground"))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                    TextField("Password", text: $password)
                        .padding()
                        .frame(width: 350, height: 50, alignment: .center)
                        .background(Color("CardBackground"))
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                       
                    
                    
                    
                    
                        Button("login".uppercased()) {
                            DispatchQueue.main.async {
                                loginService.Login(userName: userName, password: password)
                                
                               
                            }
                           
                        
                        }
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50, alignment: .center)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(10)
                        .padding()
                        
                    Spacer()
                    
                }//: VSTACK
                .padding()
            }//: ZSTACK
        //NAV VIEW
    }
    
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
