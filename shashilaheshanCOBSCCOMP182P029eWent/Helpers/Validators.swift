//
//  Validators.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 29/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
class ValidateFields {
    
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
final class EmailValidator {
    
    func validate(_ input: String) -> Bool {
        guard
            let regex = try? NSRegularExpression(
                pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}",
                options: [.caseInsensitive]
            )
            else {
                assertionFailure("Regex not valid")
                return false
        }
        
        let regexFirstMatch = regex
            .firstMatch(
                in: input,
                options: [],
                range: NSRange(location: 0, length: input.count)
        )
        
        return regexFirstMatch != nil
    }
}
