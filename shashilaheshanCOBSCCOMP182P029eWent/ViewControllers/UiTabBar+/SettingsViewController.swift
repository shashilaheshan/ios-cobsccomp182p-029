//
//  SettingsViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 17/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        try! Auth.auth().signOut()
    }
    
}
