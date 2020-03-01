//
//  Slide.swift
//  eWent
//
//  Created by Shashila Heshan on 7/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit

class Slide: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
    var btnAval: Bool = false
    
    @IBOutlet weak var txtTitle: UILabel!
    
    @IBOutlet weak var txtDescription: UILabel!
    
    @IBOutlet weak var btnNext: UIButton!
    
    override func layoutSubviews() {
        if(!btnAval) {
            
            btnNext.isHidden = true
        } else {
             btnNext.isHidden = false
        }
    }
    //Login page if user preses Let's login button in get starter window
    @IBAction func goToLogin(_ sender: Any) {
      
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        
        let setViewController = mainStoryboard.instantiateViewController(withIdentifier: "Login_SB") as! LoginVC
        
        let rootViewController = self.window!.rootViewController
        
        rootViewController?.present(setViewController, animated: true, completion: nil)
        
        }
    }

