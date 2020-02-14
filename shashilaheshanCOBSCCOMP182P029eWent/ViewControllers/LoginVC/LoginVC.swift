//
//  LoginVC.swift
//  eWent
//
//  Created by Shashila Heshan on 7/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import Lottie

class LoginVC: UIViewController , UIViewControllerTransitioningDelegate {

   
    @IBOutlet weak var aV: AnimationView!
    
     let transition = CircularTransition()
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var btnGuest: UIButton!
    
    
   // @IBOutlet weak var txtP: UICustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        loginView.bindToKeyboard()
       // txtPassword.becomeFirstResponder()
//        txtPassword.isEnabled = false
//        txtUsername.isEnabled = false
    
        AnimationController.playAnimation(aV: aV, name: "15230-illustration-animation")
        
        
        
//
//        btnLogin.layer.backgroundColor = Colors.black.cgColor
//
        btnRegister.layer.backgroundColor = Colors.black.cgColor

        btnGuest.layer.backgroundColor = Colors.black.cgColor
        

        
        
       // btnLogin.setGradientBackground(colorOne: Colors.green, colorTwo: Colors.darkGreen)
//        btnGuest.layer.cornerRadius = btnGuest.frame.size.height/2
//        btnGuest.layer.masksToBounds = true
       // btnGuest.setGradientBackground(colorOne: Colors.orange, colorTwo: Colors.brightOrange)
//        btnRegister.layer.cornerRadius = btnRegister.frame.size.height/2
//        btnRegister.layer.masksToBounds = true
//        btnRegister.setGradientBackground(colorOne: Colors.orange, colorTwo: Colors.brightOrange)
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "forgotpasswordVC" {
            let controller = segue.destination as! ForgotPasswordVC
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .custom
           
        } else if segue.identifier == "registerVC" {
            let controller = segue.destination as! RegisterVC
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .custom
          
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        AnimationController.playAnimation(aV: aV, name: "15230-illustration-animation")
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = btnLogin.center
        transition.circleColor = Colors.green
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = btnLogin.center
        transition.circleColor = Colors.green
        
        return transition
    }
    
}
