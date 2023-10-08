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
    @Published var searchedOrganization : [OrganizationModel] = []
    @Published var orgAdmin : [OrgAdminModel] = []
    @Published var orgModel : OrganizationModel?
    
    
    @Published var drugList : [DrugModel] = []
    @Published var searchedDrugList : [DrugModel] = []
    
    
    @Published var investigationList : [InvestigationModel] = []
    @Published var searchedInvestigationList : [InvestigationModel] = []
    
    @Published var specialityList : [SpecialityListModel] = []
    @Published var searchedSpecialityList : [SpecialityListModel] = []
    
    @Published var page = -1
    @Published var size = 10
    
    
    @AppStorage("AuthToken") var AuthToken : String = ""
    
    var tt  = "eyJhbGciOiJIUzI1NiJ9.eyJyb2xlIjpbeyJhdXRob3JpdHkiOiJST0xFX1JPT1QifV0sInN1YiI6InJvb3QiLCJpYXQiOjE2OTYyMjczNzIsImV4cCI6MTY5NjMxMzc3Mn0.SsGEkpg7emAfWRWMd63POlr6DMYC5N5iKddetb8Jxzg"
    
    //MARK: - GET ALL ORGANIZATION
    func getOrganizationDetails(from apiUrl : String){
        
        page += 1
        
        guard let url = URL(string: "\(apiUrl)?page=\(page)&size=\(size)")
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
                                let decodedData = try decoder.decode([OrganizationModel].self, from: data)
                               // self?.organization = decodedData
                                self?.organization.append(contentsOf: decodedData)
                                
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
    
    //MARK: - CREATE ORGANIZATION
    
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
    
    
    //MARK: - UPDATE ORGANIZATION
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
    
    //MARK: - GET SINGLE ORGANIZATION
    func getSingleOrganization(from apiUrl : String, for id : Int){
        
        guard let url = URL(string: "\(apiUrl)\(id)")
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
    
    
    //MARK: - SEARCH ORGANIZATION
    
    func searchOrganization(orgType : String, name : String){
   // http://localhost:9191/organization/search/Hospital/rain?page=0&size=25
       
        guard let url = URL(string: "\(K.SEARCH_ORGANIZATION)\(orgType)/\(name)?page=0&size=50") else {
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
                                let decodedData = try decoder.decode([OrganizationModel].self, from: data)
                                self?.searchedOrganization = decodedData
                                
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
    
    
    // MARK: - CREATE ORG ADMIN
    func createOrgAdmin(admin : OrgAdminModel){
        
        let admin = admin
        
        guard let url = URL(string: "\(K.ADD_ORG_ADMIN)") else {
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
    
    
    //MARK: - GET ORGANIZATION ADMIN
    func getOrgAdmin(orgID : Int){
        guard let url = URL(string: "\(K.GET_ORG_ADMIN)\(orgID)?page=0&size=50")
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
                                let decodedData = try decoder.decode([OrgAdminModel].self, from: data)
                                self?.orgAdmin = decodedData
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
    
    
    //MARK: - GET DRUG LIST
    
    func getAllGlobalDrugs(){
        
        page += 1
        guard let url = URL(string: "\(K.GET_ALL_DRUGS_GLOBAL)?page=\(page)&size=\(size)")
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
                                //self?.drugList = decodedData
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
    
    //MARK: - GET DRUG BY BRAND
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
    
    // MARK: - CREATE DRUG
    
    func createDrug(drug : DrugModel){
        let drug = drug
        
        guard let url = URL(string: "\(K.CREATE_DRUG)") else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = AuthToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let jsonData = drug
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
    
    //MARK: - UPDATE DRUG
    
    func updateDrug(drug : DrugModel, drugID : Int){
        let drug = drug
        
        //let org = OrganizationModel(name: "Poly", address: "Something", contact: "01677397270", type: "Diagnostic Center", email: "diagonostic@yahoo.com", emergencyContact: "01911362438", operatingHour: "9 AM - 5 PM")
        
        //TODO
        guard let url = URL(string: "\(K.UPDATE_DRUG)\(drugID)") else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = AuthToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let jsonData = drug
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
    
    
    //MARK: - GET ALL INVESTIGATION
    
    func getAllInvestigation() {
      
        page += 1
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
                                self?.investigationList.append(contentsOf: decodedData)
                                
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
   
        guard let url = URL(string: "\(K.GET_INVESTIGATOIN_BY_NAME)\(name)?page=0&size=50") else {
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
    
    //MARK: - ADD INVESTIGATION
    
    func addInvestigation(investigation : InvestigationModel){
        let investigation = investigation
        
        guard let url = URL(string: "\(K.ADD_INVESTIGATION)") else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = AuthToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let jsonData = investigation
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
    
    
    //MARK: - UPDATE INVESTIGATION
    
    func updateInvestigation(investigation : InvestigationModel, investigationId : Int){
        let investigation = investigation
        
        
        guard let url = URL(string: "\(K.UPDATE_INVESTIGATION_BY_ID)\(investigationId)") else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = AuthToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let jsonData = investigation
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
    
    
    //MARK: - GET GLOBAL SPECIALITY
    
    func getAllSepcialityGlobal(){
     
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
                                self?.specialityList.append(contentsOf: decodedData)
                                
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
    
    //MARK: - ADD SPECIALITY
    
    func addSpeciality(speciality : SpecialityListModel){
        let speciality = speciality
        
        guard let url = URL(string: "\(K.ADD_SPECIALITY)") else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = AuthToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let jsonData = speciality
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
    
    //MARK: - UPDATE SPECIALITY
    
    func updateSpeciality(speciality : SpecialityListModel, specialityId : Int){
        let speciality = speciality
        
        
        guard let url = URL(string: "\(K.UPDATE_SPECIALITY_BY_ID)\(specialityId)") else {
            print("Invalid Posting URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = AuthToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let jsonData = speciality
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
    
    
    
}

