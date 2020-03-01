//
//  Event.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit

class Location{
    var name:String!
    var lat :Double!
    var lng :Double!
    init(name:String!,lat:Double!,lng:Double!) {
        self.name = name
        self.lat = lat
        self.lng = lng
    }
}

class Event {
    
    var event_name :String!
    var event_location : Location!
    var description :String!
    var datetime :String!
    var image :UIImage!
    var imageURL : String!
    var eventId :String!
    var userId :String!
    
    init(eVM : EventViewModel) {
        self.event_name = eVM.event_name
        self.event_location = eVM.event_location
        self.description = eVM.description
        self.datetime  = eVM.datetime
        self.image = eVM.eventImages
        self.eventId = eVM.eventId
        self.imageURL = eVM.imgURL
    
    }
    init(event: String,e_location : Location,desc :String,date_time :String,img :UIImage,eID :String,userId : String,imgurl :String) {
        self.event_name = event
        self.event_location = e_location
        self.description = desc
        self.datetime = date_time
        self.image = img
        self.eventId = eID
        self.userId = userId
        self.imageURL = imgurl
    }
    init(event: String,e_location : Location,desc :String,date_time :String,eID :String,userId : String,imgurl :String) {
        self.event_name = event
        self.event_location = e_location
        self.description = desc
        self.datetime = date_time
        self.eventId = eID
        self.userId = userId
        self.imageURL = imgurl
    }
}
