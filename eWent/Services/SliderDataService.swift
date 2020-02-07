//
//  SliderDataService.swift
//  eWent
//
//  Created by Shashila Heshan on 7/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
class SliderData {
    
    static func getSliderData(completion:((_ _json : Data?)-> Void)){
        completion(Data(UtilsApp.SLIDER_DATA.utf8))
    }
}
