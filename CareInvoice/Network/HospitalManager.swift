//
//  HospitalManager.swift
//  CareInvoice
//
//  Created by Jotno on 9/24/23.
//

import Foundation

import SwiftUI

class HospitalManager : ObservableObject {
    
    @Published var specialities : [SpecialityListModel] = []
    
    @AppStorage("AuthToken") var AuthToken : String = ""
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var tt : String = "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX09SR19BRE1JTiJ9XSwic3ViIjoic29oYW4xIiwiaWF0IjoxNjk1NzIxOTYyLCJleHAiOjE2OTU4MDgzNjJ9.mLW7OC3gPehVnaGj8wQc1uamgGPEmFUVGqm-_ZWmqbU"
    
    
    
    //MARK: - GET ALL SPECIALITY
    func getAllSepcialityByOrg(orgID : Int){
        
        guard let url = URL(string: K.GET_ALL_SPECIALITY_GLOBAL)
        else
        {
            print("Invalid URL")
            return
        }
      
        let token = AuthToken
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
                                let decodedData = try decoder.decode([SpecialityListModel].self, from: data)
                                self?.specialities = decodedData
                                
                            } catch  {
                                print("Could not decode Speciality List \(error)")
                            }
                        
                            
                            
                        }else{
                            print("Could Not Fetch Data")
                        }
                    }
                } //:DispatchQueue
            }.resume()
    }
    
}
