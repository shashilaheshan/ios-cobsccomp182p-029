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
            "batch": user.batch!
        ]) { err in
            if let err = err {
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                completion(true)
            }
        }

    }
    public func getProfileData(completion :@escaping (Profile)->()) {
        
        Fbc.shared.collection("users").document("bso")
        .getDocument { (snapshot, err) in
            if let data = snapshot?.data() {
                
                let profile = Profile(mail: data["email"] as! String, fname: data["name"] as! String, batc: data["batch"] as! String)
                
                DispatchQueue.main.async {
                    completion(profile)
                }
            } else {
                print("Couldn't find the document")
            }
        }
        
        
    }
}
