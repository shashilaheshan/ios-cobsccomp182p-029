//
//  Profile.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 14/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation

struct Profile {
    
    var email :String?
    var f_name :String?
    var commiunity :String?
    var image : String?
    
    init(mail : String,fname :String,batc :String,img :String) {
        
        self.email = mail
        self.f_name = fname
        self.commiunity = batc
        self.image = img
    }
    init() {
        
        
    }
}
