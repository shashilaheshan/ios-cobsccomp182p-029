//
//  AlertViews.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 26/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
enum Alert {
    case Error
    case Success
    case Waiting
    case Loading
}

class ShowAlert {
    static func showAlertMessage(title:String,message:String,type:Alert,vc:UIViewController) -> UIAlertView  {
        
        
        
        var alert: UIAlertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "Cancel")
        
        switch type {
        case .Error:
            return alert
        case  .Loading:
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x:50, y:10, width:37, height:37))
            loadingIndicator.center = vc.view.center;
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating()
            alert.setValue(loadingIndicator, forKey: "accessoryView")
            return alert
        case .Success:

            return alert
        
            
        case .Waiting:
             return alert
        }
       
    }
}
