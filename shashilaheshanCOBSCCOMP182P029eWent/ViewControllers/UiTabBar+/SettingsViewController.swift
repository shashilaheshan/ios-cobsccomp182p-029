//
//  SettingsViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 17/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import FirebaseAuth
import LocalAuthentication
import RxSwift

class SettingsViewController: UIViewController {
    var isDarkMode:Bool = false
    
    @IBOutlet weak var chkDarkModel: UISwitch!
    @IBOutlet weak var chkNotifications: UISwitch!
    
    @IBOutlet weak var txtDarkMode: UILabel!
    @IBOutlet weak var txtSettingHeading: UILabel!
    @IBOutlet weak var btnLogout: UiButtonCustom!
    @IBOutlet weak var txtAppVersion: UILabel!
    var authViewModel :AuthViewModel = AuthViewModel()
    
    @IBOutlet weak var txtNotification: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chkDarkModel.isOn = false
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        self.txtAppVersion.text = "eWent App Version \(appVersion!)"
        
        
    }
    @IBAction func enableNotifications(_ sender: Any) {
    }
    @IBAction func enableDarkMode(_ sender: Any) {
        self.enableDarkMode()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        
    }
    
    
    @IBAction func btnLogout(_ sender: Any) {
        
        self.authViewModel.loggedOutDelegate = self
        
        self.authViewModel.logOutUser()
    }
    
    
    func enableDarkMode(){
        if(!self.isDarkMode){
            self.view.layer.backgroundColor = UIColor.black.cgColor
            self.txtAppVersion.textColor = UIColor.orange
            self.txtDarkMode.textColor = UIColor.orange
            self.txtNotification.textColor = UIColor.orange
            self.txtSettingHeading.textColor = UIColor.orange
            btnLogout.layer.backgroundColor = UIColor.orange.cgColor
            self.isDarkMode = true
        }else{
            self.view.layer.backgroundColor = UIColor.white.cgColor
            self.txtAppVersion.textColor = UIColor.black
            self.txtDarkMode.textColor = UIColor.black
            self.txtNotification.textColor = UIColor.black
            self.txtSettingHeading.textColor = UIColor.black
            btnLogout.layer.backgroundColor = UIColor.purple.cgColor
             self.isDarkMode = false
        }
       
        
    }
}

