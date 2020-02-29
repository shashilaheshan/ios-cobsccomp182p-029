//
//  AuthDataService.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit



class AuthDataService {
    
    static let def = UserDefaults.standard
    
    func registerUser(user : User,completion :@escaping (Bool,Bool)->())  {
        
        AuthC.shared.createUser(withEmail: user.email, password: user.password) { (AuthDataResult, Error) in
            
            if Error == nil {
                
                FirebaseStorageService.uploadImages(user.image, email: user.email,type: .Profile) {
                    url, success in
                    
                    user.image_url = url
                    ProfileDataService.saveProfileData(user: user) { success in
                        if(success)
                        {
                            
                            DispatchQueue.main.async {
                                completion(true,false)
                            }
                            
                        }else {
                            
                            DispatchQueue.main.async {
                                completion(false,false)
                            }
                        }
                    }
                }
              
               
            }else{
                DispatchQueue.main.async {
                    completion(false,false)
                }
                
            }
        }
    }
    func loginUser(user : User,completion :@escaping (Bool,Bool)->())  {
        
        AuthC.shared.signIn(withEmail: user.email, password: user.password, completion: { (AuthDataResult, error) in
        
              if error == nil {
                
                        DispatchQueue.main.async {
                            
                            UserDefaults.standard.setLoggedIn(value: true)
                            
                            UserDefaults.standard.setUserID(value: user.email)
                            DispatchQueue.main.async {
                                 completion(true,false)
                            }
                           
                        }
              } else {
                    DispatchQueue.main.async {
                        
                         UserDefaults.standard.setLoggedIn(value: false)
                        
                        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userID.rawValue)
                        
                        DispatchQueue.main.async {
                            completion(false,false)
                        }
                        
                    }
              }
       })
    }
    
    
}
