//
//  OrganizationManager.swift
//  CareInvoice
//
//  Created by Jotno on 9/14/23.
//

import Foundation
import SwiftUI

class OrganizationManager : ObservableObject {
    
    @Published var organization : [OrganizationModel] = []
    @Published var orgModel : OrganizationModel?
    
    @AppStorage("AuthToken") var AuthToken : String = ""
    
    var tt  = "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX1JPT1QifV0sInN1YiI6InJvb3QiLCJpYXQiOjE2OTU1MzE0NTUsImV4cCI6MTY5NTYxNzg1NX0.hrN8yjre_atCdYw4-aEsm-JWI1NkbHO-ARk_v7PhUCw"
    
    
    func getOrganizationDetails(from apiUrl : String){
        
        guard let url = URL(string: apiUrl)
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
                                let decodedData = try decoder.decode([OrganizationModel].self, from: data)
                                self?.organization = decodedData
                                
                            } catch  {
                                print("Could not decode Organization \(error)")
                            }
                        
                            
                            
                        }else{
                            print("Could Not Fetch Data")
                        }
                    }
                } //:DispatchQueue
            }.resume()
    }
    
    func postOrganization(organization: OrganizationModel, to apiUrl : String){
        
        let org = organization
        
        //let org = OrganizationModel(name: "Poly", address: "Something", contact: "01677397270", type: "Diagnostic Center", email: "diagonostic@yahoo.com", emergencyContact: "01911362438", operatingHour: "9 AM - 5 PM")
        
        guard let url = URL(string: apiUrl) else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = AuthToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
    
    
    func updateOrganization(organization: OrganizationModel,to apiUrl : String, for id : Int){
        
        let org = organization
        
        //let org = OrganizationModel(name: "Poly", address: "Something", contact: "01677397270", type: "Diagnostic Center", email: "diagonostic@yahoo.com", emergencyContact: "01911362438", operatingHour: "9 AM - 5 PM")
        
        //TODO
        guard let url = URL(string: "\(apiUrl)\(id)") else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = AuthToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
    
    
    func getSingleOrganization(from apiUrl : String, for id : Int){
        
        guard let url = URL(string: "\(apiUrl)\(id)")
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
                                let decodedData = try decoder.decode(OrganizationModel.self, from: data)
                                self?.orgModel = decodedData
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
    
    func createOrgAdmin(admin : OrgAdminModel, orgID : Int){
        
        let admin = admin
        
        guard let url = URL(string: "\(K.ADD_ORG_ADMIN)\(orgID)") else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = AuthToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let jsonData = admin
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
