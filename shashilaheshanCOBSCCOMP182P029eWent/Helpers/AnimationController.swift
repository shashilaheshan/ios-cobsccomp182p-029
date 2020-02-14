//
//  AnimationController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 8/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import Lottie
import UIKit
public class AnimationController {
    
    static  func playAnimation(aV : AnimationView , name : String ){
        aV.animation = Animation.named(name)
        aV.loopMode = .loop
        aV.play()
    }
}
