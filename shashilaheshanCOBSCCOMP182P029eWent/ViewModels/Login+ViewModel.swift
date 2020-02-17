//
//  Login+ViewModel.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import RxSwift
class LoginViewModel {
    
    var email : String!
    var password :String!
  
    
    private let authDataService : AuthDataService = AuthDataService()
    
    private let is_loading = Variable(false)
    var isLoading :Observable<Bool>{
        return is_loading.asObservable()
    }
    
    init(e_mail :String,p_word :String) {
        
        self.email = e_mail
        self.password = p_word
       
        
    }
    func loginUser()  {
        self.is_loading.value = true
        authDataService.loginUser(user: User(lvm: self)) {suceess ,loading  in
            self.is_loading.value = loading
        }
    }
    
    /// call if user logged in
    static func saveLoggedState(userID :String) {
        
        let def = UserDefaults.standard
        
        def.set(true, forKey: "is_authenticated") // save true flag to UserDefaults
        
        def.set(userID, forKey: "userID")
        
        def.synchronize()
        
    }
}
