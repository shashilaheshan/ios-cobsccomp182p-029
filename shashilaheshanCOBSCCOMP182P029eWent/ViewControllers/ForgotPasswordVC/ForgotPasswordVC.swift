//
//  ForgotPasswordVC.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 12/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import Lottie

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var aV: AnimationView!
    
    @IBOutlet weak var txtUsernameToReset: UICustomTextField!
    
    @IBOutlet weak var btnForgotPassword: UiButtonCustom!
    
    var authModel:AuthViewModel = AuthViewModel()
    
     var keyBOb :KeyboardListeners!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.keyBOb = KeyboardListeners(view: self)
        
        self.setupView()
        
        
    }
    

    @IBAction func btnResetPassword(_ sender: Any) {
      
        self.authModel.forgotPasswordDelegate = self
        self.authModel.sendForgotPasswordLink(email: txtUsernameToReset.text!)
    }
    func navigateToLogin(alert: UIAlertAction!) {
       self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
