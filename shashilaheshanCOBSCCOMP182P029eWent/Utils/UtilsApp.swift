//
//  Utils.swift
//  eWent
//
//  Created by Shashila Heshan on 7/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit

struct Colors {
    
    static let brightOrange     = UIColor(red: 255.0/255.0, green: 69.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let red              = UIColor(red: 255.0/255.0, green: 115.0/255.0, blue: 115.0/255.0, alpha: 1.0)
    static let orange           = UIColor(red: 255.0/255.0, green: 175.0/255.0, blue: 72.0/255.0, alpha: 1.0)
    static let blue             = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 228.0/255.0, alpha: 1.0)
    static let green            = UIColor(red: 199/255, green: 255/255, blue: 0/255, alpha: 1.0)
    static let darkGrey         = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)
    static let veryDarkGrey     = UIColor(red: 13.0/255.0, green: 13.0/255.0, blue: 13.0/255.0, alpha: 1.0)
    static let lightGrey        = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
    static let black            = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let white            = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    static let darkGreen        = UIColor(red: 0/255, green: 237/255, blue: 225/255, alpha: 1.0)
    static let darkBlack        = UIColor(red: 20/255, green: 0/255, blue: 11/255, alpha: 1.0) /* #14000b */
}

public struct UtilsApp {
    static let APP_NAME: String = "eWent"
    
    static let APP_DARK_MODE_ENABLED : Bool = false
    
    static let APP_VERSION : String = "1.00"
    
    static let APP_LOCALE : String = "EN"
    
    static let APP_REGION : String = "Asia-Colombo"
    
    static let SLIDER_DATA = """
       {
      "sliders":[
         {
            "image" : "ic_onboarding_1",
            "title" :"A real-life bear",
            "description":"Did you know that Winnie the chubby little cubby was based on a real, young bear in London",
            "getstart":"0"
         },
        {
            "image" : "ic_onboarding_1",
            "title" :"A real-life bear",
            "description":"Did you know that Winnie the chubby little cubby was based on a real, young bear in London",
            "getstart":"0"
         },
        {
            "image" : "ic_onboarding_1",
            "title" :"A real-life bear",
            "description":"Did you know that Winnie the chubby little cubby was based on a real, young bear in London",
            "getstart":"1"
         }
       ]

     }
    """
}
