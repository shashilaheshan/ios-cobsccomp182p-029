//
//  EventDataService.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation

class EventDataService  {
     let def = UserDefaults.standard
    
    func saveEventData(event : Event,completion :@escaping (String,Bool)->())  {
      
        let ref =  Fbc.shared.collection("events")
        let docId = ref.document().documentID
               Fbc.shared.collection("events").document(docId).setData([
                "e_name" : event.event_name!,
                "e_location":event.event_location!,
                "e_desc":event.description!,
                "e_datetime":event.datetime!,
                "e_image":event.image!,
                "userId": def.value(forKey: "userID") ?? "0"
                
               ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        DispatchQueue.main.async {
                            completion("Data saved successfully",false)
                        }
                    }
                }
           }
    
    func fetchAllEvents(completion :@escaping([Event])->())  {
        Fbc.settings.isPersistenceEnabled = false
        var events :[Event] = [Event]()
        Fbc.shared.collection("events").addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
              events.removeAll()
                for document in querySnapshot!.documents {
            
                    events.append(Event(event: document.data()["e_name"] as! String, e_location: document.data()["e_location"] as! String, desc: document.data()["e_desc"] as! String, date_time: document.data()["e_datetime"] as! String, img: document.data()["e_image"] as! String,eID :document.documentID ?? "100",userId: document.data()["userId"] as! String))
                  
                }
               
                DispatchQueue.main.async {
                     completion(events)
                }
                
            }
        }
    }
    func likeToSingleEvent(eventId :String)  {
        Fbc.shared.collection("events").document(eventId).collection("likes").addDocument(data: [
            "user": "shashila",
            "time" : "2020-02-16"
            
        ]) { (Error) in
            
            if (Error == nil) {
                print("Like added")
            }
        }
    }
    func commentToSingleEvent(eventId :String,comment: String)  {
     
        Fbc.shared.collection("events").document(eventId).collection("comments").addDocument(data: [
            "user": "shashila",
            "comment" : comment,
            "datetime" : "2020-02-19"
            
        ]) { (Error) in
            
            if (Error == nil) {
                print("Comment added")
            }
        }
    }
    func checkIfUserLikedToAnEvent(eventId : String,completion :@escaping(Bool)->()){
        Fbc.shared.collection("events").document(eventId).collection("likes").whereField("user", isEqualTo: "shashila").addSnapshotListener{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if((querySnapshot?.documents.count)!>0){
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }else{
                    
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }
      }
    }
    func getLikeCountForEachEvent(eventId : String,completion :@escaping(Int)->()){
        Fbc.shared.collection("events").document(eventId).collection("likes").whereField("user", isEqualTo: "shashila").addSnapshotListener{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if((querySnapshot?.documents.count)!>0){
                    DispatchQueue.main.async {
                        completion((querySnapshot?.documents.count)!)
                    }
                }else{
                    
                    DispatchQueue.main.async {
                        completion(100)
                    }
                }
            }
        }
    }
}
