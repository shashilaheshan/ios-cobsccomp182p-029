//
//  ProfileViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 14/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var txtFEmail: UICustomTextField!
    
    @IBOutlet weak var txtFFname: UICustomTextField!
    
    @IBOutlet weak var txtFBatch: UICustomTextField!
    
    let profileViewModel : ProfileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    @IBAction func btnUpdateProfileInfo(_ sender: Any) {
        self.profileViewModel.getProfileInfo()
        
        //self.profileViewModel.saveProfileInfo(profileD : Profile(mail: txtFEmail.text!, fname: txtFFname.text!, batc:txtFBatch.text!))
    }
    

}
