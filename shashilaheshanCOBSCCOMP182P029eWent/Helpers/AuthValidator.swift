//
//  AuthValidator.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 3/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import LocalAuthentication

class AuthValidator {
    
    
    static func isBiometryReady() -> Bool
    {
        let context : LAContext = LAContext();
        var error : NSError?
        
        context.localizedFallbackTitle = ""
        context.localizedCancelTitle = "Enter Using Passcode"
        
        if (context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error))
        {
            return true
        }
        
        if error?.code == -8
        {
            let reason:String = "TouchID has been locked out due to few fail attemp. Enter iPhone passcode to enable TouchID.";
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication,
                                   localizedReason: reason,
                                   reply: { (success, error) in
                                    
                                    return false
                                    
            })
            
            return true
        }
        
        return false
    }
    
}
