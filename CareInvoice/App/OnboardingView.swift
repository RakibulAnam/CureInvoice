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
    @State var isLoggedIn : Bool = false
    
    var body: some View {
        
        NavigationView {
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
                        .frame(width: 300, height: 50)
                        .background(Color("CardBackground"))
                        .cornerRadius(10)
                    TextField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color("CardBackground"))
                        .cornerRadius(10)
                       
                    NavigationLink(destination: SuperAdminHomeView(), isActive: $isLoggedIn) {
                        Button("login".uppercased()) {
                       // postTest()
                        isLoggedIn  = true
                        }
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 50, alignment: .center)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(10)
                        .padding()
                    }//: NAVIGATION LINK
                    

                    
                        
                    Spacer()
                    
                }//: VSTACK
                .padding()
            }//: ZSTACK
        }//NAV VIEW
    }
    
    func postTest(){
        
        let org = OrganizationModel(name: "Poly", address: "Something", contact: "01677397270", type: "Diagnostic Center", email: "diagonostic@yahoo.com", emergencyContact: "01911362438", operatingHour: "9 AM - 5 PM")
        
        guard let url = URL(string: "http://localhost:9191/organization/create") else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = org
        let encoder = JSONEncoder()
        
        if let encodedData = try? encoder.encode(jsonData){
            
            request.httpBody = encodedData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                                print("ErrorBro: \(error.localizedDescription)")
                                return
                            }
                
                if let data = data {
                             do {
                                 // Parse the response data if needed
                                 let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                                 print(jsonResponse)
                             } catch {
                                 print("JSON Error: \(error.localizedDescription)")
                             }
                }
            }.resume()
            
            
        }
       
        
        
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
