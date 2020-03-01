//
//  Login+ViewModel.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginViewModelDelegate {
    
    func didLoggedIn(success : Bool)
    
}
class LoginViewModel {
    
    var email : String!
    var password :String!
  
    var loginViewModelDelegate : LoginViewModelDelegate?
    
    private let authDataService : AuthDataService = AuthDataService()
    
    var emailText = Variable<String>("")
    var passwordText = Variable<String>("")
    var isValid :Observable<Bool> {
        
        return Observable.combineLatest(emailText.asObservable(),passwordText.asObservable()){ emailT,passwordT in
            emailT.count >= 3 && passwordT.count >= 8 && ValidateFields.isValidEmail(email: emailT)
            
        }
    }
 
    
    private let is_loading = Variable(false)
    var isLoading :Observable<Bool>{
        return is_loading.asObservable()
    }

    init(){
        
    }
    init(e_mail :String,p_word :String) {
        
        self.email = e_mail
        self.password = p_word
       
        
    }
    func loginUser()  {
        
        self.is_loading.value = true
        if(validateLoginCredentials(email: self.email, password:self.password)) {
            self.authDataService.loginUser(user: User(lvm: self)) {suceess ,loading  in
                
                self.is_loading.value = loading
                
                DispatchQueue.main.async {
                    self.loginViewModelDelegate?.didLoggedIn(success: suceess)
                }
                
            }
        }else{
            self.is_loading.value = false
            DispatchQueue.main.async {
                self.loginViewModelDelegate?.didLoggedIn(success: false)
            }
            
        }
       
    }
    
    func validateLoginCredentials(email:String,password:String)-> Bool {
        
        return password.count >= 8 && ValidateFields.isValidEmail(email: email)
    }
}
