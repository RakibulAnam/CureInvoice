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
    
    @Published var doctorModel : DoctorModel?
    
    
    @Published var invoiceModel : AppointmentInvoiceModel?
    
    @Published var searchedinvoiceList : [AppointmentInvoiceModel] = []
    @Published var patientList : [PatientModel] = []
    @Published var adminList : [AdminModel] = []
    
    @Published var searchedSpecialityList : [SpecialityListModel] = []
    
    
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
    
    //MARK: - SEARCH SPECIALITY
    func getSearchedSpeciality(name : String){
       
        
        guard let url = URL(string: "\(K.GET_SPECIALITY_BY_NAME)\(name)?page=0&size=50") else {
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
                                let decodedData = try decoder.decode([SpecialityListModel].self, from: data)
                                self?.searchedSpecialityList = decodedData
                                
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
    
    
    
    //MARK: - GET SINGLE DOCTOR
    
    func getDoctorProfile(docID : Int){
        
        guard let url = URL(string: "\(K.GET_DOCTOR_PROFILE)\(docID)")
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
                                let decodedData = try decoder.decode(DoctorModel.self, from: data)
                                self?.doctorModel = decodedData
                                
                            } catch  {
                                print("Could not decode Doctor Model \(error)")
                            }
                        
                            
                            
                        }else{
                            print("Could Not Fetch Data")
                        }
                    }
                } //:DispatchQueue
            }.resume()
    }
    
    
    
    
    //MARK: - CREATE DOCTOR
    
    func createDoctor(doctor : DoctorModel, orgId : Int, completion: @escaping (OrgUserError?) -> Void){
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
    
    //MARK: - UPDATE DOCTOR ---------------------------
    
    func updateDoctor(doctor : DoctorModel, docId : Int, completion: @escaping (OrgUserError?) -> Void){
        let model = doctor
        
        //let org = OrganizationModel(name: "Poly", address: "Something", contact: "01677397270", type: "Diagnostic Center", email: "diagonostic@yahoo.com", emergencyContact: "01911362438", operatingHour: "9 AM - 5 PM")
        
        //TODO
        guard let url = URL(string: "\(K.UPDATE_DOCTOR)\(docId)") else {
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
    
    
    //MARK: - MAKE APPOINTMENT
    
    func makeAppointment(invoice : AppointmentInvoiceModel, completion: @escaping (OrgUserError?, Bool) -> Void){
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
                            completion(.duplicateData, false)
                        }
                        else if response.contains("empty"){
                            completion(.emptyTextField, false)
                        }
                        else {
                            completion(nil,true)
                        }
                        
                        do {
                            let decodedData = try JSONDecoder().decode(AppointmentInvoiceModel.self, from: data)
                            DispatchQueue.main.async {
                                self.invoiceModel = decodedData
                                completion(nil, true)
                            }
                            
                            
                        } catch  {
                            completion(.urlProblem, false)
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
        
        guard let url = URL(string: "\(K.SEARCH_APPOINTMENT_INVOICE)\(orgId)/\(name)?page=0&size=50")
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
                        if response.contains("Email Already Taken") || response.contains("Username is Already Taken"){
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
    
    
}
