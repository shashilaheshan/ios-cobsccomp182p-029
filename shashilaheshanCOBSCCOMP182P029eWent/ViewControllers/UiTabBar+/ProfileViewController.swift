//
//  ProfileViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 14/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {
    let def = UserDefaults.standard
    @IBOutlet weak var txtFEmail: UICustomTextField!
    
    @IBOutlet weak var txtFFname: UICustomTextField!
    
    @IBOutlet weak var txtBatchC: UICustomTextField!
   
    
    @IBOutlet weak var imgProfile: UIImageView!
    
     var is_image_picked:Bool = false
    
    var imagePicker : UIImagePickerController!
    
    var profileViewModel : ProfileViewModel = ProfileViewModel()
    
    var authViewModel :AuthViewModel = AuthViewModel()
    
     var keyBOb :KeyboardListeners!
    
    private let disposeBag  = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.keyBOb = KeyboardListeners(view: self)
        self.setupView()
       
       
    }
    override func viewDidAppear(_ animated: Bool) {
        self.authViewModel.authModelDelegate = self
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        self.authViewModel.authenticateUser()
    }
    @IBAction func btnSelectProfileImage(_ sender: Any) {
        let alert = UIAlertController(title: "Select source", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
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
    @IBAction func btnUpdateProfileInfo(_ sender: Any) {
        let img:UIImage!
        
        if is_image_picked {
            img = imgProfile.image!
        }else{
            img = nil
        }
      
        let alert = ShowAlert.showAlertMessage(title: "Please wait", message: "Updating profile...", type: .Waiting, vc: self)
        self.profileViewModel.profileUpdateDelegate = self
        self.profileViewModel = ProfileViewModel(mail: txtFEmail.text!, fname:txtFFname.text!, batc: txtBatchC.text!, image: img)
        
        self.profileViewModel.isLoading.subscribe(onNext: {
            [weak self] loading in
            
            if(loading){
                alert.show();
            }else {
                alert.dismiss(withClickedButtonIndex: 0, animated: true)
                
            }
        }).disposed(by: disposeBag)
        
        self.profileViewModel.updateProfileData()
    }
    

}
