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
import RxCocoa
class RegisterVC: UIViewController {

    //@IBOutlet weak var registerView: AnimationView!
    
    @IBOutlet weak var txtEmail: UICustomTextField!
    
    @IBOutlet weak var txtNickName: UICustomTextField!
    
    
    @IBOutlet weak var txtFName: UICustomTextField!
    
    
    @IBOutlet weak var txtPassword: UICustomTextField!
    
    
    @IBOutlet weak var txtBatch: UICustomTextField!
    
     var registerViewModel : RegisterViewModel = RegisterViewModel()
    
    private let disposeBag  = DisposeBag()
    
    @IBOutlet weak var imgProfilePicture: UIImageView!
    
    @IBOutlet weak var btnselectImage: UIButton!
    
    var imagePicker : UIImagePickerController!
    
    @IBOutlet weak var btnRegister: UiButtonCustom!
    
     var keyBOb :KeyboardListeners!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
         self.keyBOb = KeyboardListeners(view: self)
       // AnimationController.playAnimation(aV: registerView, name: "9710-registration-of-animated-illustrations")
        
        self.setupView()
        
    }
    
    @IBAction func btnDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSelectImage(_ sender: Any) {
       
        let alert = UIAlertController(title: "Select source", message: "Select image location", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "CAMERA", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
           self.imagePicker.sourceType = .camera
           self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "GALLERY", style: UIAlertAction.Style.default, handler:{(action:UIAlertAction!) in
         self.imagePicker.sourceType = .photoLibrary
         self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
       
    }
    @IBAction func btnRegisterUser(_ sender: Any) {
        
        if self.imgProfilePicture.image?.imageAsset != nil {
            let alert = ShowAlert.showAlertMessage(title: "Please wait", message: "Registering User...", type: .Loading, vc: self)
            
            self.registerViewModel = RegisterViewModel(e_mail: txtEmail.text!, n_name: txtNickName.text!, f_name:txtFName.text! , p_word: txtPassword.text!, btch: txtBatch.text!,image: self.imgProfilePicture.image!,image_url: "")
            
            self.registerViewModel.isLoading.subscribe(onNext: {
                [weak self] loading in
                
                if(loading){
                    alert.show();
                }else {
                    alert.dismiss(withClickedButtonIndex: 0, animated: true)
                    
                }
            }).disposed(by: disposeBag)
            self.registerViewModel.registerUser()
        }else{
               let alert = ShowAlert.showAlertMessage(title: "Error", message: "Please select profile image..", type: .Error, vc: self)
               alert.show()
        }
        
    }
    
    @IBAction func btnGuestLogin(_ sender: Any) {
    }
}
