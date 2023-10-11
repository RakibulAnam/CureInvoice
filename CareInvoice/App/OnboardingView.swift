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
    @StateObject var manager = OrganizationManager()
    @AppStorage("OrgID") var OrgID : Int = 0
    @AppStorage("OrgType") var OrgType : String = ""
    @AppStorage("isLoggedIn") var isLoggedIn : Bool = false
    @State private var showAlert = false
    
    
    
    
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
                    Text("CareInvoice")
                        .font(.custom("Cairo-Regular", size: 30))
                        .foregroundColor(.accentColor)
                }
                
                TextField("Username", text: $userName)
                    .padding()
                    .frame(width: 350, height: 50, alignment: .center)
                    .background(Color("CardBackground"))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 350, height: 50, alignment: .center)
                    .background(Color("CardBackground"))
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                
                
                
                
                Button {
                    DispatchQueue.main.async {
                        
                        loginService.Login(userName: userName, password: password, completion: {success in
                            if success {
                                
                            } else {
                                showAlert = true
                            }
                        })
                        
                    }
                } label: {
                    Text("login".uppercased())
                        .font(.custom("Cairo-Regular", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50, alignment: .center)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(10)
                        .padding()
                }
                .alert("Please Enter Valid Username and Password", isPresented: $showAlert){
                    Button("OK", role: .cancel) {
                        
                    }
                }

                
                /*
                Button("login".uppercased()) {
                    DispatchQueue.main.async {
                        
                        loginService.Login(userName: userName, password: password, completion: {success in
                            if success {
                                
                            } else {
                                showAlert = true
                            }
                        })
                        
                    }
 
                }
                .font(.custom("Cairo-Regular", size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 350, height: 50, alignment: .center)
                .background(Color("PrimaryColor"))
                .cornerRadius(10)
                .padding()
                .alert("Please Enter Valid Username and Password", isPresented: $showAlert){
                    Button("OK", role: .cancel) {
                        
                    }
                }
                 */
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
