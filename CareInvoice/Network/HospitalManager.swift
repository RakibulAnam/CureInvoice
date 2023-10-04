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
    
    
    @AppStorage("AuthToken") var AuthToken : String = ""
    @AppStorage("OrgID") var OrgID : Int = 0
    
    var tt : String = "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX09SR19BRE1JTiJ9XSwic3ViIjoic29oYW4xIiwiaWF0IjoxNjk1NzIxOTYyLCJleHAiOjE2OTU4MDgzNjJ9.mLW7OC3gPehVnaGj8wQc1uamgGPEmFUVGqm-_ZWmqbU"
    
    @Published var page = 0
    @Published var size = 50
    
    
    
    //MARK: - GET ALL SPECIALITY
    func getAllSepcialityByOrg(orgID : Int){
        
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
    
    
    //MARK: - GET ALL DOCTORS
    
    func getDoctors(orgID : Int, specialityID : Int){
        
        guard let url = URL(string: "\(K.GET_DOCTOR_BY_ORG_SPT)\(orgID)/\(specialityID)?page=\(page)&size=\(size)")
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
    
    func makeAppointment(invoice : AppointmentInvoiceModel){
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
                                self?.invoiceList = decodedData
                                
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
    
    func getPatientList(orgId: Int, name : String){
        guard let url = URL(string: "\(K.GET_PATIENT_BY_ORG)\(orgId)/\(name)") else {
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
    
    
}
