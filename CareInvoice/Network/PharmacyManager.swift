//
//  PharmacyManager.swift
//  CareInvoice
//
//  Created by Jotno on 9/26/23.
//

import Foundation
import SwiftUI

class Pharmacymanager : ObservableObject {
    
    @Published var drugList : [DrugModel] = []
    @AppStorage("AuthToken") var AuthToken : String = ""
    
    var tt = "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX09SR19BRE1JTiJ9XSwic3ViIjoic29oYW4xIiwiaWF0IjoxNjk1NzIxOTYyLCJleHAiOjE2OTU4MDgzNjJ9.mLW7OC3gPehVnaGj8wQc1uamgGPEmFUVGqm-_ZWmqbU"
    
    func getAllDrugs() {
        guard let url = URL(string: K.GET_ALL_DRUGS)
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
                                let decodedData = try decoder.decode([DrugModel].self, from: data)
                                self?.drugList = decodedData
                                
                            } catch  {
                                print("Could not decode Drug List \(error)")
                            }
                        
                            
                            
                        }else{
                            print("Could Not Fetch Data")
                        }
                    }
                } //:DispatchQueue
            }.resume()
    }
    
}

