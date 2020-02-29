//
//  User.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
class User {
    
    var email : String!
    var nickName :String!
    var fullName :String!
    var password :String!
    var batch :String!
    var image :UIImage!
    var image_url : String!
    
    init(rvm : RegisterViewModel) {
        self.email = rvm.email
        self.nickName = rvm.nickName
        self.fullName = rvm.fullName
        self.password = rvm.password
        self.batch = rvm.batch
        self.image = rvm.image
        self.image_url = rvm.image_url
    }
    init(lvm : LoginViewModel) {
        self.email = lvm.email
        self.password = lvm.password
    }
    init(emails:String,nicknames:String,fullnames:String,images:String) {
        
        self.email = emails
        self.nickName = nicknames
        self.fullName = fullnames
        self.image_url = images
    }
}
