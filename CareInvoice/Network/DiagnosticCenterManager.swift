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
    @Published var searchedInvestigationList : [InvestigationModel] = []
    
    
    @Published var invoiceList : [InvestigationInvoiceModel] = []
    
    @Published var adminList : [AdminModel] = []
    @AppStorage("AuthToken") var AuthToken : String = ""
    
    var tt = "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX09SR19BRE1JTiJ9XSwic3ViIjoic2FyaWYxIiwiaWF0IjoxNjk2MTQ0NTIzLCJleHAiOjE2OTYyMzA5MjN9.BCkV6dP7kohJbrdWzxU47sTgi6Xe5hu4fuZS-sSEpiA"
    
    @Published var page = 0
    @Published var size = 50
    
    
    
    //MARK: - GET INVESTIGATIONS
    func getAllInvestigation(orgId : Int) {
        guard let url = URL(string: "\(K.GET_ALL_INVESTIGATIONS_GLOBAL)?page=\(page)&size=\(size)")
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
   
    func getInvestigationByName(name: String){
        guard let url = URL(string: "\(K.GET_INVESTIGATOIN_BY_NAME)\(name)?page=\(page)&size=\(size)") else {
            print("invalid URL")
            return
        }
        
        let token = AuthToken
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
                                self?.searchedInvestigationList = decodedData
                                
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
    
    //MARK: - GET AND CREATE ADMIN
    
    func getAllAdmin(orgID : Int){
        guard let url = URL(string: "\(K.GET_ADMIN)\(orgID)?page=\(page)&size=\(size)")
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
                                let decodedData = try decoder.decode([AdminModel].self, from: data)
                                self?.adminList = decodedData
                            } catch  {
                                print("Could Not Decode Admin Profile Data")
                            }
                            
                        }else{
                            print("Could Not Fetch Data")
                        }
                    }
                } //:DispatchQueue
            }.resume()
    }
    
    func createAdmin(admin : AdminModel){
        
        let admin = admin
        
        guard let url = URL(string: "\(K.ADD_ADMIN)") else {
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
    
    //MARK: - BOOK INVESTIGATION
    func bookInvestigation(invoice : InvestigationInvoiceModel){
        let invoice = invoice
        
        guard let url = URL(string: "\(K.BOOK_INVESTIGATION)") else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = AuthToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let jsonData = invoice
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
    
    
    // MARK: - GET ALL INVOICE
    
    func getAllInvoice(orgId : Int){
        guard let url = URL(string: "\(K.GET_INVESTIGATION_INVOICE)\(orgId)?page=\(page)&size=\(size)")
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
                                let decodedData = try decoder.decode([InvestigationInvoiceModel].self, from: data)
                                self?.invoiceList = decodedData
                                
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
