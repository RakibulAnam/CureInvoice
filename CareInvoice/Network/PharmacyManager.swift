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
    @Published var searchedDrugList : [DrugModel] = []
    @Published var drugModel : DrugModel?
    
    @Published var invoiceList : [DrugInvoiceModel] = []
    
    @Published var invoiceModel : DrugInvoiceModel?
    
    @Published var searchedinvoiceList : [DrugInvoiceModel] = []
    @Published var adminList : [AdminModel] = []
    @Published var patientList : [PatientModel] = []
    @AppStorage("AuthToken") var AuthToken : String = ""
    
    @Published var page = -1
    @Published var size = 10
    
    var tt = "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX09SR19BRE1JTiJ9XSwic3ViIjoic2FyaWYxIiwiaWF0IjoxNjk1ODE0MDg4LCJleHAiOjE2OTU5MDA0ODh9.7XYdDB-IU5AO-sWHo6CE55VsYCGh9mkbPEQoq9eHBvc"
    
    //MARK: - GET ALL DRUGS
    func getAllDrugs(orgID : Int) {
        
        page += 1
        
        guard let url = URL(string: "\(K.GET_ALL_DRUGS_BY_ORG)\(orgID)?page=\(page)&size=\(size)")
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
                                let decodedData = try decoder.decode([DrugModel].self, from: data)
                                self?.drugList.append(contentsOf: decodedData)
                                
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
    
    //MARK: - Search Drug
    
    func getDrugBrand(name : String){
        
        guard let url = URL(string: "\(K.GET_BRAND_DRUG)\(name)?page=0&size=50") else {
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
                                let decodedData = try decoder.decode([DrugModel].self, from: data)
                                self?.searchedDrugList = decodedData
                                
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
    
    
    //MARK: - GET DRUG PROFILE
    
    func getDrugProfile(drugId : Int, orgId : Int){
        
        guard let url = URL(string: "\(K.GET_DRUGS_PROFILE)\(drugId)/\(orgId)") else {
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
                                let decodedData = try decoder.decode(DrugModel.self, from: data)
                                self?.drugModel = decodedData
                                
                            } catch  {
                                print("Could not decode Drug Profile \(error)")
                            }
                        
                            
                            
                        }else{
                            print("Could Not Fetch Data")
                        }
                    }
                } //:DispatchQueue
            }.resume()
        
        
    }
    
    
    
    
    //MARK: - Create Invoice
    
    func createInvoice(invoice : DrugInvoiceModel, completion: @escaping (Bool) -> Void){
        guard let url = URL(string: K.CREATE_PHARMACY_INVOICE) else {
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
                        
                        do {
                            let decodedData = try JSONDecoder().decode(DrugInvoiceModel.self, from: data)
                            DispatchQueue.main.async {
                                self.invoiceModel = decodedData
                                completion(true)
                            }
                            
                            
                        } catch  {
                            completion(false)
                            print("-----Could not decode Drug Model \(error.localizedDescription)------")
                        }
                        
                        
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
        page += 1
        guard let url = URL(string: "\(K.GET_PARMACY_INVOICE)\(orgId)?page=\(page)&size=\(size)")
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
                                let decodedData = try decoder.decode([DrugInvoiceModel].self, from: data)
                                self?.invoiceList.append(contentsOf: decodedData)
                                
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
    
    //MARK: - SEARCH INVOICE
    
    func searchInvoice(orgId : Int, name: String){
        
//        page += 1
        
        guard let url = URL(string: "\(K.SEARCH_DRUG_INVOICE)\(orgId)/\(name)?page=0&size=50")
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
                                let decodedData = try decoder.decode([DrugInvoiceModel].self, from: data)
                                self?.searchedinvoiceList = decodedData
                                
                            } catch  {
                                print("Could not decode Invoice List \(error)")
                            }
                        
                            
                            
                        }else{
                            print("Could Not Fetch Data")
                        }
                    }
                } //:DispatchQueue
            }.resume()
        
    }
    
    
    
    // MARK: - GET ADMINS
    
    func getAllAdmin(orgID : Int){
        guard let url = URL(string: "\(K.GET_ADMIN)\(orgID)?page=0&size=50")
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
    
    
    
    // MARK: - CREATE ADMIN
    
    func createAdmin(admin : AdminModel, completion: @escaping (OrgUserError?) -> Void){
        
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
                        let response = "\(jsonResponse)"
                        if response.contains("Email Already Taken") || response.contains("Username is Already Taken") || response.contains("Duplicate entry"){
                            completion(.duplicateData)
                        }
                        else if response.contains("empty"){
                            completion(.emptyTextField)
                        }
                        else {
                            completion(nil)
                        }
                        print(jsonResponse)
                    } catch {
                        print("JSON Error: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
        
        
    }
    
    //MARK: - UPDATE ADMIN
    func updateAdmin(model : AdminModel, adminId : Int, completion: @escaping (OrgUserError?) -> Void){
        let model = model
        
        //let org = OrganizationModel(name: "Poly", address: "Something", contact: "01677397270", type: "Diagnostic Center", email: "diagonostic@yahoo.com", emergencyContact: "01911362438", operatingHour: "9 AM - 5 PM")
        
        //TODO
        guard let url = URL(string: "\(K.UPDATE_ADMIN)\(adminId)") else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = AuthToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let jsonData = model
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
                        
                        let response = "\(jsonResponse)"
                        if response.contains("Email Already Taken") || response.contains("Username is Already Taken") || response.contains("Duplicate entry"){
                            completion(.duplicateData)
                        }
                        else if response.contains("empty"){
                            completion(.emptyTextField)
                        }
                        else {
                            completion(nil)
                        }
                        
                        print(jsonResponse)
                        
                    } catch {
                        print("JSON Error: \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
    }
    
    //MARK: - Search patients
    
    func getPatientList(orgId: Int, name : String){
        guard let url = URL(string: "\(K.GET_PATIENT_BY_ORG)\(orgId)/\(name)?page=0&size=50") else {
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
                                let decodedData = try decoder.decode([PatientModel].self, from: data)
                                self?.patientList = decodedData
                                
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
    
    
    //MARK: - UPDATE ORG DRUG DETAILS
    
    func updateOrgDrugDetails(model : UpdateOrgDrugModel){
        let model = model
        
        
        guard let url = URL(string: "\(K.UPDATE_DRUG_FOR_ORG)") else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = AuthToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let jsonData = model
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
    
    //MARK: - Search During Order
    
    func searchDuringOrder(orgId : Int, name : String){
        
        guard let url = URL(string: "\(K.SEARCH_DRUGS_DURING_ORDER)\(orgId)/\(name)?page=0&size=50") else {
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
                                let decodedData = try decoder.decode([DrugModel].self, from: data)
                                self?.searchedDrugList = decodedData
                                
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

