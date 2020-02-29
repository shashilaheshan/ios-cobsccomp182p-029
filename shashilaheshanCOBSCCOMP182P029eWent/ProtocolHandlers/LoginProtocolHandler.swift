//
//  LoginProtocolHandler.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 26/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
extension LoginVC : LoginViewModelDelegate {
    func didLoggedIn(success: Bool) {
        if(success) {
            self.performSegue(withIdentifier: "homeView", sender: nil)
        }else {
            ShowAlert.showAlertMessage(title: "Error", message: "Username or password is incorrect please try again ", type: .Error, vc: self).show()
        }
    }
    
   
}
