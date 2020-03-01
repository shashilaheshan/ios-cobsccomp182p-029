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
                DispatchQueue.main.async {
                    completion(true)
                }
            }
        }
        
    }
    fileprivate func updateAndReturnSingleProfileData(profile:Profile,completion :@escaping (Bool)->())  {
        
        if(profile.image == nil) {
            Fbc.shared.collection("users").document(profile.email!).updateData([
                "name": profile.f_name!,
                "batch": profile.commiunity!
                
                
            ]) { err in
                if let err = err {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                    
                }
            }
        }else {
            Fbc.shared.collection("users").document(profile.email!).updateData([
                "name": profile.f_name!,
                "batch": profile.commiunity!,
                "profile_image_url":profile.image!
                
            ]) { err in
                if let err = err {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                    
                }
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
    
    func updateProfile(profile:Profile ,completion:@escaping(Bool)->()){
        if profile.imageData == nil {
            self.updateAndReturnSingleProfileData(profile: profile){ success in
                DispatchQueue.main.async {
                    completion(success)
                }
            }
        }else {
            FirebaseStorageService.uploadImages(profile.imageData!, email: profile.email!, type: .Profile) { (url
                , Bool) in
                if url != ""  {
                    profile.image = url
                }
                self.updateAndReturnSingleProfileData(profile: profile){ success in
                    DispatchQueue.main.async {
                        completion(success)
                    }
                }
            }
        }
    }
    
}
