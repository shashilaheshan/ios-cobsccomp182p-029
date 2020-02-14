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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnimationController.playAnimation(aV: aV, name: "1397-animation-for-monobank")
    }
    

    @IBAction func btnResetPassword(_ sender: Any) {
        
        let alertC = UIAlertController(title: "Email sent..", message: "Your password reset link has been sent..", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertC.addAction(alertAction)
        present(alertC, animated: true, completion: nil)
    }
    
    @IBAction func btnDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
