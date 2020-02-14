//
//  RegisterVC.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 8/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import Lottie
class RegisterVC: UIViewController {

    @IBOutlet weak var registerView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        AnimationController.playAnimation(aV: registerView, name: "9710-registration-of-animated-illustrations")
       
    }
    
    @IBAction func btnDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
