

import Foundation
import SwiftUI




struct loginData : Codable {
    var name : String
    var password : String
}

struct loginResponse : Codable{
    var token : String
}

class LoginService : ObservableObject{
    
    @AppStorage("AuthToken") var AuthToken : String = ""
    
    func Login(userName: String, password : String){
        
        guard let url = URL(string: K.Login.AUTHENTICATE) else {
            print("Error Finding the URL")
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        var body = loginData(name: userName, password: password)
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("There was an error \(error)")
            } else {
                if let data = data {
                    
                    var safeData = try? JSONDecoder().decode(loginResponse.self, from: data)
                    
                    self.AuthToken = safeData!.token
                    
                } else{
                    print("Didnt Get Data")
                }
            }
            
        }.resume()
            
        
        
        
    }
    
}

