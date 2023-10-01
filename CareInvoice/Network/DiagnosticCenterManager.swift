//
//  DiagnosticCenterManager.swift
//  CareInvoice
//
//  Created by Jotno on 10/1/23.
//

import Foundation
import SwiftUI

class DiagnosticCenterManager : ObservableObject {
    
    @Published var investigationList : [InvestigationModel] = []
    @Published var adminList : [AdminModel] = []
    @AppStorage("AuthToken") var AuthToken : String = ""
    
    var tt = "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX09SR19BRE1JTiJ9XSwic3ViIjoic2FyaWYxIiwiaWF0IjoxNjk2MTQ0NTIzLCJleHAiOjE2OTYyMzA5MjN9.BCkV6dP7kohJbrdWzxU47sTgi6Xe5hu4fuZS-sSEpiA"
    
    
    func getAllInvestigation() {
        guard let url = URL(string: K.GET_ALL_INVESTIGATIONS)
        else
        {
            print("Invalid URL")
            return
        }
      
        let token = AuthToken
        var request = URLRequest(url: url)
        request.addValue("Bearer \(tt)", forHTTPHeaderField: "Authorization")
        
        URLSession
            .shared
            .dataTask(with: request) {[weak self] data, response, error in
                
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        print("There was an error starting the session \(error)")
                    }
                    else{
                        
                        let decoder = JSONDecoder()
                        
                        if let data = data {
                            
                            
                            do {
                                let decodedData = try decoder.decode([InvestigationModel].self, from: data)
                                self?.investigationList = decodedData
                                
                            } catch  {
                                print("Could not decode Investigation List \(error)")
                            }
                        
                            
                            
                        }else{
                            print("Could Not Fetch Data")
                        }
                    }
                } //:DispatchQueue
            }.resume()
    }
    
    
    
}
