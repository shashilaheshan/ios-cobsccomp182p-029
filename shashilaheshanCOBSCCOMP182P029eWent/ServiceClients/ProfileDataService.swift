//
//  ProfileDataService.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 14/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation

class ProfileDataService {

    static func saveProfileData(user : User,completion :@escaping(Bool)->()) {

        Fbc.shared.collection("users").document(user.email!).setData([
            "name": user.fullName!,
            "email": user.email!,
            "nickname":user.nickName!,
            "batch": user.batch!,
            "profile_image_url": user.image_url!
        ]) { err in
            if err != nil {
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                completion(true)
            }
        }

    }
    
    
    public func getProfileData(email:String,completion :@escaping (Profile)->()) {
        
        Fbc.shared.collection("users").document(email)
        .getDocument { (snapshot, err) in
            if let data = snapshot?.data() {
                
                let profile = Profile(mail: data["email"] as! String, fname: data["name"] as! String, batc: data["batch"] as! String ,img: data["profile_image_url"] as! String)
                
                DispatchQueue.main.async {
                    completion(profile)
                }
            } else {
                print("Couldn't find the document")
            }
        }
        
        
    }
}
