//
//  LoginProtocolHandler.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 26/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
extension LoginVC : LoginViewModelDelegate,SetupViewProtocol {
   
    func setupView() {
       
        AnimationController.playAnimation(aV: aV, name: "15230-illustration-animation")
       
        
        self.keyBOb.setupKeyboardObservers()
        
        _ = txtUsername.rx.text.map {$0 ?? ""}.bind(to: loginViewModel.emailText)
        _ = txtPassword.rx.text.map {$0 ?? ""}.bind(to: loginViewModel.passwordText)
        
        _ = loginViewModel.isValid.bind(to: btnLogin.rx.isEnabled)
        
        loginViewModel.isValid.subscribe(onNext : { isValid in
            if(isValid) {
                UIView.animate(withDuration: 1.0) {
                    self.btnLogin.layer.backgroundColor =  UIColor.black.cgColor
                    
                }
                
            }else{
                UIView.animate(withDuration: 1.0) {
                    self.btnLogin.layer.backgroundColor =  UIColor.red.cgColor
                    
                }
            }
            
        })
        
        
        
    }

    func didLoggedIn(success: Bool) {
        if(success) {
            self.performSegue(withIdentifier: "homeView", sender: nil)
        }else {
            ShowAlert.showAlertMessage(title: "Error", message: "Username or password is incorrect please try again ", type: .Error, vc: self).show()
        }
    }
    
    
}
