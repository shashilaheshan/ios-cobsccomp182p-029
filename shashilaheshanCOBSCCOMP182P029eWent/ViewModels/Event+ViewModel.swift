//
//  Event+ViewModel.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol EventViewModelDelegate {
    func didFinishFetchingEvents(events:[Event])
    
    func checkUserLikedToAnEvent(like : Bool,cell : CustomEventPostCellTableViewCell)
    
    func getLikeCountForEachEvent(count : Int,cell : CustomEventPostCellTableViewCell)
    
}
class EventViewModel {
    
    
    var event_name :String!
    var event_location :Location!
    var description :String!
    var datetime :String!
    var image :String!
    var eventId :String!
    var eventImages : UIImage?
    var imgURL :String!
    
    var eventViewModelDelegate : EventViewModelDelegate?
    
    var eventDataService : EventDataService = EventDataService()
    
    private let is_loading = Variable(false)
    var isLoading :Observable<Bool>{
        return is_loading.asObservable()
    }
    
    var eventTxt = Variable<String>("")

    var eventDescTxt = Variable<String>("")
    
    
    var isValid :Observable<Bool> {
        
        return Observable.combineLatest(eventTxt.asObservable(),eventDescTxt.asObservable()){ eT,eDt in
            eT.count >= 2  && eDt.count >= 5
            
        }
    }
    init(){}
   
    init(eventname :String,eventlocaton :Location,desc : String,date_time :String ,eID :String,eventImage: UIImage?,imgURL:String) {
        self.event_name = eventname
        self.event_location = eventlocaton
        self.description = desc
        self.datetime = date_time
        self.eventImages = eventImage
        self.eventId = eID
        self.imgURL = imgURL
    }
    
    func saveEventData()  {
        self.is_loading.value = true
        self.eventDataService.saveEventData(event: Event(eVM: self)) { data,success  in
            
          
            self.is_loading.value = false
        }
    }
    
    func fetchAllEvents(){
        
        self.eventDataService.fetchAllEvents { events in
            self.eventViewModelDelegate?.didFinishFetchingEvents(events: events)
        }
    }
    
    func editEventData() {
        self.is_loading.value = true
        self.eventDataService.updateEventCore(event: Event(eVM: self)) { success  in
            self.is_loading.value = success
        }
    }
//    func goingSingleEvent(eventId:String,userId:String,completion:@escaping(Bool)->()) {
//        self.eventDataService.goingToSingleEvent(eventId: eventId, userId: userId){ success in
//            if(success) {
//                completion(true)
//            }else{
//               completion(false)
//            }
//        }
//    }
    func goingNotGoingToSingleEvent(eventId:String,userId:String,completion:@escaping(Bool)->()) {
        self.eventDataService.goingNotGoingToSingleEvent(eventId: eventId, userId: userId){ success in
            if(success) {
                completion(true)
            }else{
                completion(false)
            }
            
        }
    }
    func commentToSingleEvent(eventId: String,comment :String) {
       self.eventDataService.commentToSingleEvent(eventId: eventId, comment: comment)
    }
    
    func checkIfUserGoingToAnEvent(eventId : String,cell : CustomEventPostCellTableViewCell){
        self.eventDataService.checkIfUserGoingNotGoingToAnEvent(eventId: eventId) { liked in
            //print(liked)
            print(eventId)
            print(liked)
            self.eventViewModelDelegate?.checkUserLikedToAnEvent(like: liked, cell: cell)
        }
    }
    func getGoingCountForEachEvent(eventId : String,cell : CustomEventPostCellTableViewCell){
        self.eventDataService.getGoingCountForEachEvent(eventId: eventId) { (count) in
            self.eventViewModelDelegate?.getLikeCountForEachEvent(count: count, cell: cell)
        }
    }
    
}

class EventsListViewModel {
    
    var eventsListViewModel : [EventListViewModel] = [EventListViewModel]()
    var eventDataService : EventDataService = EventDataService()
    
    func populateEvents(_events : [Event])  {
        self.eventsListViewModel = _events.map(EventListViewModel.init)
    }
    
    
}

class EventListViewModel {
    
    var event_name :String!
    var event_location :Location!
    var description :String!
    var datetime :String!
    var image :String!
    var event_id :String!
    var userId: String!
    init(eModel : Event) {
        self.event_name = eModel.event_name
        self.event_location = eModel.event_location
        self.description = eModel.description
        self.datetime = eModel.datetime
        self.image = eModel.imageURL
        self.event_id = eModel.eventId
        self.userId = eModel.userId
    }
    
    
}
