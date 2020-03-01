//
//  Profile.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 14/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit

class Profile {
    
    var email :String?
    var f_name :String?
    var commiunity :String?
    var image : String?
    var imageData : UIImage?
    
    init(mail : String,fname :String,batc :String,img :String) {
        
        self.email = mail
        self.f_name = fname
        self.commiunity = batc
        self.image = img
    }
    init(pvm:ProfileViewModel) {
        self.email = pvm.email
        self.f_name = pvm.f_name
        self.commiunity = pvm.batch
        self.imageData = pvm.image
       
        
    }
}
