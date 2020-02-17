//
//  User.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
class User {
    
    var email : String!
    var nickName :String!
    var fullName :String!
    var password :String!
    var batch :String!
    
    init(rvm : RegisterViewModel) {
        self.email = rvm.email
        self.nickName = rvm.nickName
        self.fullName = rvm.fullName
        self.password = rvm.password
        self.batch = rvm.batch
    }
    init(lvm : LoginViewModel) {
        self.email = lvm.email
        self.password = lvm.password
    }
}
