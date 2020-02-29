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
    static let default_image_profile :String = "https://scontent.fcmb3-1.fna.fbcdn.net/v/t1.0-1/c0.0.160.160a/p160x160/75339702_2451156151668669_8419901170373361664_o.jpg?_nc_cat=106&_nc_ohc=hFwg6kZo6jEAX_5S8c6&_nc_ht=scontent.fcmb3-1.fna&oh=861573f35278bf6653192c851aaf1d79&oe=5EB53CBA"
    static let default_event_image :String = "https://wallpaperstock.net/green-nature-wallpapers_21556_1680x1050.jpg"
}
