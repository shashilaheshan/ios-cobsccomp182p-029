//
//  Event+ViewModel.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation

import RxSwift

class EventViewModel {
    
    
    var event_name :String!
    var event_location :String!
    var description :String!
    var datetime :String!
    var image :String!
    
  
    
    var eventDataService : EventDataService = EventDataService()
    
    private let is_loading = Variable(false)
    var isLoading :Observable<Bool>{
        return is_loading.asObservable()
    }
    init(){}
   
    init(eventname :String,eventlocaton :String,desc : String,date_time :String ,img :String) {
        self.event_name = eventname
        self.event_location = eventlocaton
        self.description = desc
        self.datetime = date_time
        self.image = img
    }
    
    func saveEventData()  {
    
        self.is_loading.value = true
        eventDataService.saveEventData(event: Event(eVM: self)) { data,success  in
            
          
            self.is_loading.value = false
        }
    }
    
    func fetchAllEvents(){
        
        self.eventDataService.fetchAllEvents { events in
            print(events[0].event_name)
        }
    }
    
    
}

class EventsListViewModel {
    
    var eventsListViewModel : [EventListViewModel] = [EventListViewModel]()
    var eventDataService : EventDataService = EventDataService()
    
//    init() {
//        self.populateEvents()
//    }
    func populateEvents(_events : [Event])  {
        self.eventsListViewModel = _events.map(EventListViewModel.init)
    }
    
    
}

class EventListViewModel {
    
    var event_name :String!
    var event_location :String!
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
        self.image = eModel.image
        self.event_id = eModel.eventId
        self.userId = eModel.userId
    }
    
    
}
