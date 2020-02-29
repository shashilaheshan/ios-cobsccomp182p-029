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
    
    static func showToast(message : String , uv : UIViewController) {
        
        let toastLabel = UILabel(frame: CGRect(x: uv.view.frame.size.width/2 - 75, y: uv.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        uv.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

