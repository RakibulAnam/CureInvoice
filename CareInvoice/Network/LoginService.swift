

import Foundation
import SwiftUI




struct loginData : Codable {
    var username : String
    var password : String
}

struct loginResponse : Codable{
    
    var token : String
    var roles : [userRoleModel]
    var orgCode : String?
    var orgId : Int
    var orgType : String
    var username : String
    var userId : Int
}


struct userRoleModel : Codable {
    let authority: String
}

class LoginService : ObservableObject{
    
    @AppStorage("AuthToken") var AuthToken : String = ""
    @AppStorage("ROLE") var userRole : String = ""
    @AppStorage("OrgID") var OrgID : Int = 0
    @AppStorage("OrgType") var OrgType : String = ""
    @AppStorage("UserName") var userName : String = ""
    @AppStorage("UserId") var UserId : Int = 0
    @AppStorage("isLoggedIn") var isLoggedIn : Bool = false
    
    
    var orgManager = OrganizationManager()
    
    func Login(userName: String, password : String, completion: @escaping (Bool) -> Void){
        
        print("Got Called")
        
        guard let url = URL(string: K.Login.AUTHENTICATE) else {
            print("Error Finding the URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = loginData(username: userName, password: password)
        request.httpBody = try? JSONEncoder().encode(body)
        
        print(userName)
        print(password)
        
        
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    print("There was an error \(error)")
                    completion(false)
                } else {
                    if let data = data {
                        print("Got DATA")
                        //print(String(data: data, encoding: .utf8))
                        DispatchQueue.main.async {
                            do {
                                let safeData = try JSONDecoder().decode(loginResponse.self, from: data)
                                self.AuthToken = safeData.token
                                print(self.AuthToken)
                                self.OrgID = safeData.orgId
                                self.OrgType = safeData.orgType
                                self.userName = safeData.username
                                self.UserId = safeData.userId
                                self.isLoggedIn = true
                                self.getRole()
                                completion(true)
                                
                            } catch  {
                                completion(false)
                                print("Couldnt Decode")
                            }
                        }
                       
                    } else{
                        completion(false)
                        print("Didnt Get Data")
                    }
                }
                
                
            }.resume()
        
        
        
            
    }
    
    func getRole() {
        
        print("Get ROle got Called")
        
        let token = AuthToken
        print("AuthToken for UserDefaults \(token)")
        var role : String = ""
        guard let url = URL(string: K.GET_ROLE) else {
            print("Invalid URL for Role")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("Started URL Session")
            if let error = error {
                print("Error starting URL session \(error)")
            }
            else if let data = data {
                print("Got Data in Role \(String(data: data, encoding: .utf8))")
                
                DispatchQueue.main.async {
                    do {
                        let safeData = try JSONDecoder().decode([userRoleModel].self, from: data)
                        print(safeData)
                        role = safeData[0].authority
                        print(role)
                        self.userRole = role
                    } catch  {
                        print("There was error Decoding Role")
                    }
                }
               
                
            }
            
        }.resume()
        
        print(role)
        
    }
    
    
    
}

