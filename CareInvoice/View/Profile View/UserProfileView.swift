//
//  UserProfileView.swift
//  CareInvoice
//
//  Created by Jotno on 10/4/23.
//

import SwiftUI

struct UserProfileView: View {
    
    var userId : Int
    
    @StateObject var manager = ProfileManager()
    
    var body: some View {
        
        VStack(spacing: 10) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250, alignment: .center)
                
            
            
//            VStack(spacing: 5){
//                Text("Name")
//                    .font(.largeTitle)
//
//                Text("ORG ADMIN")
//
//                Text("ORGANIZATION")
//            }
            
            if let profile = manager.userProfile {
                VStack(spacing: 5){
                    Text(profile.name)
                        .font(.largeTitle)
                    if profile.roles == K.Role.ROOT {
                        Text("Super Admin")
                    }
                    else if profile.roles == K.Role.ORG_ADMIN {
                        Text("Organization Admin")
                        Text(profile.orgName)
                    }
                    else if profile.roles == K.Role.NORMAL_ADMIN {
                        Text("Admin")
                        Text(profile.orgName)
                    }
                    
                    
                    
                }
            }
            
            
                
                
//
//            VStack{
//
//            }
//            .font(.title2)
//            .fontWeight(.light)
           
            
        }
        .padding()
        .onAppear{
            manager.getUserProfile(userID: userId)
        }
        
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(userId: 1)
            .previewLayout(.sizeThatFits)
    }
}
