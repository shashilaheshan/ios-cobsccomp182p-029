//
//  UiButtonCustom.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 8/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class UiButtonCustom: UIButton {
    
    @IBInspectable
    var titleText: String? {
        didSet {
            
            self.setTitle(titleText, for: UIControl.State.normal)
            
        }
    }
    @IBInspectable
    var titleColor: UIColor? {
        didSet {
            
            self.setTitleColor(titleColor, for: .normal)
            
        }
    }
    @IBInspectable
    var borderColor: UIColor? {
        didSet {
            
            self.layer.borderColor = borderColor?.cgColor
            self.layer.borderWidth = 0.8
            
        }
    }
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            
            
        }
    }
    @IBInspectable
    var shadow : UIColor? {
        didSet {
            self.layer.shadowColor = shadow?.cgColor
            self.layer.shadowRadius = 20
            self.layer.shadowOpacity = 0.5
            self.layer.masksToBounds = false
            self.layer.shadowOffset = CGSize(width: 2, height: 3)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
}
