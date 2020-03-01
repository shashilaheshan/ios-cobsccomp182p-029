//
//  AuthViewModel.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 29/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation

import LocalAuthentication
import UIKit
import RxSwift
protocol AuthViewModeDelegate {
    func didAuthenticated(success: Bool)
}
protocol LogOutDelegate{
    
    func didLoggedOutUser(success:Bool)
}
protocol ForgotPasswordDelegate {
    func didSendForgotPasswordLink(success : Bool,message : String)
}

class AuthViewModel {
    
    var authModelDelegate:AuthViewModeDelegate?
    var loggedOutDelegate :LogOutDelegate?
    var forgotPasswordDelegate :ForgotPasswordDelegate?
    var authDataService: AuthDataService = AuthDataService()
    
    var emailText = Variable<String>("")
    var temp = Variable<Bool>(true)
    
    var isValid : Observable<Bool> {
        
        return Observable.combineLatest(emailText.asObservable(),temp.asObservable()){ emailT,temp in
            emailT.count >= 3  && ValidateFields.isValidEmail(email: emailT) && temp
            
        }
    }
    
    
    fileprivate func isBiometryReady() -> Bool
    {
        let context : LAContext = LAContext();
        var error : NSError?
        
        context.localizedFallbackTitle = ""
        context.localizedCancelTitle = "Enter Using Passcode"
        
        if (context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error))
        {
            return true
        }
        
        if error?.code == -8
        {
            let reason:String = "TouchID has been locked out due to few fail attemp. Enter iPhone passcode to enable TouchID.";
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication,
                                   localizedReason: reason,
                                   reply: { (success, error) in
                                    
                                    return false
                                    
            })
            
            return true
            
            
        }
        
        return false
    }
    func authenticateUser(){
        if(isBiometryReady()){
            
            self.authModelDelegate?.didAuthenticated(success: true)
            
        }else{
            self.authModelDelegate?.didAuthenticated(success: false)
        }
    }
    func getAuthenticatedUser(completion :@escaping(Bool)->()){
        let def = UserDefaults.standard
        
        if let user =  AuthC.shared.currentUser {
            if(def.value(forKey: "userID") == nil){
                DispatchQueue.main.async {
                    completion(false)
                }
            }else{
                DispatchQueue.main.async {
                    completion(true)
                }
            }
        }else {
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
    
    func logOutUser() {
        do {
            UserDefaults.standard.setLoggedIn(value: false)
            
            UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userID.rawValue)
            
            try AuthC.shared.signOut()
            
            self.loggedOutDelegate?.didLoggedOutUser(success: true)
            
        } catch let error {
            print(error)
            
        }
        
    }
    
    func sendForgotPasswordLink(email:String){
        
        self.authDataService.sendForgotPassword(email: email) { (Bool, String) in
            
            self.forgotPasswordDelegate?.didSendForgotPasswordLink(success: Bool, message: String)
        }
    }
    
    
}



extension ProfileViewController : AuthViewModeDelegate{

    func didAuthenticated(success: Bool) {
        self.validateBiometricAuthentication(valid: success)
    }
    
    func validateBiometricAuthentication(valid :Bool){
        if(valid){
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Identify yourself!"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                    [unowned self] success, authenticationError in
                    
                    DispatchQueue.main.async {
                        if success {
                            // self.runSecretCode()
                            self.tabBarController?.selectedIndex = 1
                            for subview in self.view.subviews {
                                if subview is UIVisualEffectView {
                                    subview.removeFromSuperview()
                                }
                            }
                        } else {
                            
                            let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(ac, animated: true)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }
                }
            } else {
                self.tabBarController?.selectedIndex = 0
                let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
                
            }
        }else{
            self.tabBarController?.selectedIndex = 0
            
        }
        
    }
    
    
    
}
extension SettingsViewController :LogOutDelegate {
    func didLoggedOutUser(success: Bool) {
        DispatchQueue.main.async {
            
            self.dismiss(animated: true, completion: {
                
            })
            
        }
       
    }
}
