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
    @Published var doctorList : [DoctorModel] = []
    @Published var invoiceList : [AppointmentInvoiceModel] = []
    @Published var patientList : [PatientModel] = []
    @Published var adminList : [AdminModel] = []
    
    
    @AppStorage("AuthToken") var AuthToken : String = ""
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var tt : String = "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX09SR19BRE1JTiJ9XSwic3ViIjoic29oYW4xIiwiaWF0IjoxNjk1NzIxOTYyLCJleHAiOjE2OTU4MDgzNjJ9.mLW7OC3gPehVnaGj8wQc1uamgGPEmFUVGqm-_ZWmqbU"
    
    @Published var page = -1
    @Published var size = 10
    
    
    
    //MARK: - GET ALL SPECIALITY
    func getAllSepcialityByOrg(orgID : Int){
        
        page += 1
        
        guard let url = URL(string: "\(K.GET_ALL_SPECIALITY_GLOBAL)?page=\(page)&size=\(size)")
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
                                self?.specialities.append(contentsOf: decodedData)
                                
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
    
    
    //MARK: - GET ALL DOCTORS
    
    func getDoctors(orgID : Int, specialityID : Int){
        
        guard let url = URL(string: "\(K.GET_DOCTOR_BY_ORG_SPT)\(orgID)/\(specialityID)?page=0&size=100")
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
                                let decodedData = try decoder.decode([DoctorModel].self, from: data)
                                self?.doctorList = decodedData
                                
                            } catch  {
                                print("Could not decode DOCTOR List \(error)")
                            }
                        
                            
                            
                        }else{
                            print("Could Not Fetch Data")
                        }
                    }
                } //:DispatchQueue
            }.resume()
    }
    
    //MARK: - CREATE DOCTOR
    
    func createDoctor(doctor : DoctorModel, orgId : Int){
        let doc = doctor
        
        guard let url = URL(string: "\(K.CREATE_DOCTOR_BY_ORG)\(orgId)") else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = AuthToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let jsonData = doc
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
    
    //MARK: - MAKE APPOINTMENT
    
    func makeAppointment(invoice : AppointmentInvoiceModel, completion: @escaping (OrgUserError?) -> Void){
        let invoice = invoice
        
        guard let url = URL(string: "\(K.MAKE_APPOINTMENT)") else {
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
                        let response = "\(jsonResponse)"
                        if response.contains("Duplicate entry"){
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
    
    //MARK: - GET ALL INVOICE
    
    func getInvoice(orgId : Int){
        
        page += 1
        
        guard let url = URL(string: "\(K.GET_APPOINTMENT_INVOICE)\(orgId)?page=\(page)&size=\(size)")
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
                                let decodedData = try decoder.decode([AppointmentInvoiceModel].self, from: data)
                                self?.invoiceList.append(contentsOf: decodedData)
                                
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
    
    //MARK: - GET SEARCHED INVOICE
    func searchInvoice(orgId : Int, name: String){
        
//        page += 1
        
        guard let url = URL(string: "\(K.SEARCH_APPOINTMENT_INVOICE)\(orgId)/\(name)?page=\(page)&size=\(size)")
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
                                let decodedData = try decoder.decode([AppointmentInvoiceModel].self, from: data)
                                self?.invoiceList.append(contentsOf: decodedData)
                                
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
    
    
    
    //MARK: - GET PATIENT LIST
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
    
    //MARK: GET ADMIN LIST
    
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
    
    //MARK: - CREATE ADMIN
    
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
                        if response.contains("Duplicate entry"){
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
    
    
}
