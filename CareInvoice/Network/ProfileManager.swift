//
//  ProfileManager.swift
//  CareInvoice
//
//  Created by Jotno on 10/4/23.
//

import Foundation
import SwiftUI

class ProfileManager : ObservableObject {
    
    @Published var userProfile : UserProfileModel?
    @AppStorage("AuthToken") var AuthToken : String = ""
    
    
    func getUserProfile(userID : Int){
        
        guard let url = URL(string: "\(K.GET_USER)\(userID)")
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
                                let decodedData = try decoder.decode(UserProfileModel.self, from: data)
                                self?.userProfile = decodedData
                            } catch  {
                                print("Could Not Decode OrgProfile Data")
                            }
                            
                            
                            
                            
                            
                            
                        }else{
                            print("Could Not Fetch Data")
                        }
                    }
                } //:DispatchQueue
            }.resume()
    }
    
    
    
}
