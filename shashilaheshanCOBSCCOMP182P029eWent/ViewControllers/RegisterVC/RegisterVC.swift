//
//  RegisterVC.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 8/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import Lottie
import RxSwift
class RegisterVC: UIViewController {

    @IBOutlet weak var registerView: AnimationView!
    
    @IBOutlet weak var txtEmail: UICustomTextField!
    
    @IBOutlet weak var txtNickName: UICustomTextField!
    
    
    @IBOutlet weak var txtFName: UICustomTextField!
    
    
    @IBOutlet weak var txtPassword: UICustomTextField!
    
    
    @IBOutlet weak var txtBatch: UICustomTextField!
    
    private var registerViewModel : RegisterViewModel!
    
    private let disposeBag  = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnimationController.playAnimation(aV: registerView, name: "9710-registration-of-animated-illustrations")
       
    }
    
    @IBAction func btnDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRegisterUser(_ sender: Any) {
        var alert: UIAlertView = UIAlertView(title: "Please wait", message: "Registering User...", delegate: nil, cancelButtonTitle: "Cancel");
        
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x:50, y:10, width:37, height:37))
        loadingIndicator.center = self.view.center;
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.setValue(loadingIndicator, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
        
        self.registerViewModel = RegisterViewModel(e_mail: txtEmail.text!, n_name: txtNickName.text!, f_name:txtFName.text! , p_word: txtPassword.text!, btch: txtBatch.text!)
        self.registerViewModel.isLoading.subscribe(onNext: {
            [weak self] loading in
            
            if(loading){
                alert.show();
            }else {
                alert.dismiss(withClickedButtonIndex: 0, animated: true)
                
            }
        }).disposed(by: disposeBag)
        self.registerViewModel.registerUser()
    }
    
    @IBAction func btnGuestLogin(_ sender: Any) {
    }
}
