//
//  KeyboardListeners.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 1/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
class KeyboardListeners {
    
    let viewC :UIViewController!
    init(view:UIViewController) {
        self.viewC = view
    }
    
    func setupKeyboardObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if viewC.view.frame.origin.y == 0 {
                viewC.view.frame.origin.y -= keyboardSize.height-100
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if viewC.view.frame.origin.y != 0 {
            viewC.view.frame.origin.y = 0
        }
    }
}
