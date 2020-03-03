//
//  RegisterProtocolHandler.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 26/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
extension RegisterVC : RegisterViewModelDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SetupViewProtocol{
    func setupView() {
        
        self.keyBOb.setupKeyboardObservers()
        
        self.imagePicker = UIImagePickerController()
        
        self.imagePicker.allowsEditing = true
        
        
        
        self.imagePicker.delegate = self
        
        self.imgProfilePicture.layer.cornerRadius = 10
        
        
        _ = txtEmail.rx.text.map {$0 ?? ""}.bind(to: registerViewModel.emailText)
        _ = txtPassword.rx.text.map {$0 ?? ""}.bind(to: registerViewModel.passwordText)
        
        _ = txtFName.rx.text.map {$0 ?? ""}.bind(to: registerViewModel.fullNameText)
        _ = txtNickName.rx.text.map {$0 ?? ""}.bind(to: registerViewModel.nicknameText)
        
        _ = txtBatch.rx.text.map{$0 ?? ""}.bind(to: registerViewModel.commiunityText)
        
        
        
        
        _ = registerViewModel.isValid.bind(to: btnRegister.rx.isEnabled)
        
        registerViewModel.isValid.subscribe(onNext : { isValid in
            if(isValid) {
                UIView.animate(withDuration: 1.0) {
                    self.btnRegister.layer.backgroundColor =  UIColor.black.cgColor
                    
                }
                
            }else{
                UIView.animate(withDuration: 1.0) {
                    self.btnRegister.layer.backgroundColor =  UIColor.red.cgColor
                    
                }
            }
            
            
        })
    }
    
    func didUserRegistered(success: Bool) {
        
        if success {
            
             self.performSegue(withIdentifier: "homeView", sender: nil)
            
        }else{
             ShowAlert.showAlertMessage(title: "Error", message: "Something went wrong please try again.", type: .Error, vc: self).show()
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imgProfilePicture.image = pickedImage
             self.imgProfilePicture.layer.cornerRadius = 10
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func validateUIChanges () {
        
    }
}
