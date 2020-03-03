//
//  LoginVC.swift
//  eWent
//
//  Created by Shashila Heshan on 7/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import Lottie
import FirebaseAuth
import RxSwift
import RxCocoa

class LoginVC: UIViewController , UIViewControllerTransitioningDelegate,UITextViewDelegate {

   
    @IBOutlet weak var scrollLogin: UIScrollView!
    @IBOutlet weak var aV: AnimationView!
    
     let transition = CircularTransition()
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UICustomPasswordTextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var btnGuest: UIButton!
    
    var loginViewModel : LoginViewModel = LoginViewModel()
    
    private var disposeBag = DisposeBag()
    
    var keyBOb :KeyboardListeners!
    
    
    
   // @IBOutlet weak var txtP: UICustomTextField!
    override func viewDidLoad() {
       
    
        super.viewDidLoad()
        
        self.keyBOb = KeyboardListeners(view: self)

        self.setupView()
       
       
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
    
    @IBAction func btnLoginUser(_ sender: Any) {
        let alert: UIAlertView = UIAlertView(title: "Please wait", message: "Loggin User...", delegate: nil, cancelButtonTitle: "Cancel");


        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x:50, y:10, width:37, height:37))
        loadingIndicator.center = self.view.center;
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.setValue(loadingIndicator, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        self.loginViewModel = LoginViewModel(e_mail: txtUsername.text!, p_word: txtPassword.text!)
        self.loginViewModel.loginViewModelDelegate = self
        
        self.loginViewModel.isLoading.subscribe(onNext: {
            [weak self] loading in

            if(loading){
                alert.show();
            }else {
                alert.dismiss(withClickedButtonIndex: 0, animated: true)

            }
        }).disposed(by: disposeBag)
        
        self.loginViewModel.loginUser()
        
    }
    @IBAction func btnGuestLogin(_ sender: Any) {
        
    }
    
    
}
