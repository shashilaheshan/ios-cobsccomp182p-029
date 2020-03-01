//
//  Comment.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 1/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
class Comment {
    
    var user : String!
    var comment :String!
    var time :String!
    init(user:String,comment:String,time:String) {
        self.user = user
        self.comment = comment
        self.time = time
    }
}
