//
//  ForgotPasswordProtocol.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 1/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
extension ForgotPasswordVC:ForgotPasswordDelegate,SetupViewProtocol{
    func setupView() {
        
        AnimationController.playAnimation(aV: aV, name: "1397-animation-for-monobank")
        
        self.keyBOb.setupKeyboardObservers()
        
        _ = txtUsernameToReset.rx.text.map {$0 ?? ""}.bind(to: self.authModel.emailText)
        
        
        _ = self.authModel.isValid.bind(to: self.btnForgotPassword.rx.isEnabled)
        
        self.authModel.isValid.subscribe(onNext : { isValid in
            if(isValid) {
                UIView.animate(withDuration: 1.0) {
                   self.btnForgotPassword.layer.backgroundColor =  UIColor.black.cgColor
                    
                }
                
            }else{
                UIView.animate(withDuration: 1.0) {
                    self.btnForgotPassword.layer.backgroundColor =  UIColor.red.cgColor
                    
                }
            }
            
        })
        
    }
    
    func didSendForgotPasswordLink(success: Bool, message: String) {
       if success {
            let alertC = UIAlertController(title: "Email sent..", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: self.navigateToLogin)
            
            alertC.addAction(alertAction)
            self.present(alertC, animated: true, completion: nil)
        }else{
            let alertC = UIAlertController(title: "Error.", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertC.addAction(alertAction)
            self.present(alertC, animated: true, completion: nil)
        }
    }
}
