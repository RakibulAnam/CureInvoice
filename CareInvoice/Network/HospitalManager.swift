//
//  HospitalManager.swift
//  CareInvoice
//
//  Created by Jotno on 9/12/23.
//

import Foundation
import SwiftUI


class HospitalManager : ObservableObject {
    
    
    @Published var hospitals : [HospitalModel] = []
    
    func getHospitalDetails(){
        
        guard let url = URL(string: K.Hospitals.GETALLHOSPITAL)
        else
        {
         print("Invalid URL")
            return
        }
        
        URLSession
            .shared
            .dataTask(with: url) {[weak self] data, response, error in
                
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        print("There was an error starting the session \(error)")
                    }
                    else{
                        
                        let decoder = JSONDecoder()
                        
                        if let data = data {
                            
                            let decodedData = try? decoder.decode([HospitalModel].self, from: data)
                            
                            self?.hospitals = decodedData!
                            
                        }else{
                            print("Could Not Fetch Data")
                        }
                    }
                } //:DispatchQueue
                
          
                
            }.resume()
        
        
        
        
    }
    
    
    
    
}
