//
//  AuthDataService.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation


class AuthDataService {
    
    func registerUser(user : User,completion :@escaping (String,Bool)->())  {
        
        AuthC.shared.createUser(withEmail: user.email, password: user.password) { (AuthDataResult, Error) in
            if Error == nil {
                ProfileDataService.saveProfileData(user: user) { success in
                   if(success)
                   {
                    
                    DispatchQueue.main.async {
                        completion("User Registerd Successfully!!!",false)
                    }
                    
                   }else {
                    
                    DispatchQueue.main.async {
                        completion("User Registerd Error!!!",false)
                     }
                    }
                }
               
            }else{
                DispatchQueue.main.async {
                    completion("User Registerd Error!!!",false)
                }
                
            }
        }
    }
    func loginUser(user : User,completion :@escaping (String,Bool)->())  {
        
        AuthC.shared.signIn(withEmail: user.email, password: user.password, completion: { (AuthDataResult, error) in
        
            if error == nil {
                
                        DispatchQueue.main.async {
                            LoginViewModel.saveLoggedState(userID : user.email!)
                            completion("User Logged In!!!",false)
                        }
            }else{
                    DispatchQueue.main.async {
                        completion("User Registerd Error!!!",false)
                    }
              }
       })
    }
}
