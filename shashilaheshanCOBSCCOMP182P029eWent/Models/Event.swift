//
//  Event.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation

class Event {
    
    var event_name :String!
    var event_location :String!
    var description :String!
    var datetime :String!
    var image :String!
    var eventId :String!
    var userId :String!
    
    init(eVM : EventViewModel) {
        self.event_name = eVM.event_name
        self.event_location = eVM.event_location
        self.description = eVM.description
        self.datetime  = eVM.datetime
        self.image = eVM.image
    
    }
    init(event: String,e_location : String,desc :String,date_time :String,img :String,eID :String,userId : String) {
        self.event_name = event
        self.event_location = e_location
        self.description = desc
        self.datetime = date_time
        self.image = img
        self.eventId = eID
        self.userId = userId
    }

//    var dictionaryDataCart : [String : AnyObject] {
//
//        var objDict : [String : AnyObject]!
//        
//        objDict["e_name"] = self.event_name
//        objDict["e_location"] = self.event_location as AnyObject?;
//        objDict["e_desc"] = self.event_location as AnyObject?;
//        objDict["e_datetime"] = self.datetime as AnyObject?;
//        objDict["e_image"] = self.image as AnyObject?
//
//        return objDict;
//    }
}
