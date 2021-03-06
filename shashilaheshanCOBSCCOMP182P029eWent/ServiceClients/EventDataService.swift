//
//  EventDataService.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import SwiftyJSON

class EventDataService  {
    let def = UserDefaults.standard
    
    func saveEventData(event : Event,completion :@escaping (String,Bool)->())  {
        
        FirebaseStorageService.uploadImages(event.image, email: "",type: .Event) {
            url, success in
            
            event.imageURL = url
            let ref =  Fbc.shared.collection("events")
            let docId = ref.document().documentID
            Fbc.shared.collection("events").document(docId).setData([
                "e_name" : event.event_name!,
                "e_location":[
                    "name":event.event_location.name!,
                    "lat":event.event_location.lat!,
                    "lng":event.event_location.lng!
                ],
                "e_desc":event.description!,
                "e_datetime":event.datetime!,
                "e_image":event.imageURL!,
                "userId": self.def.value(forKey: "userID") ?? "0"
                
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
        
        
    }
    
    func updateSingleEvent(event : Event,completion :@escaping (String,Bool)->())  {
        
        if(event.image == nil) {
            Fbc.shared.collection("events").document(event.eventId!).updateData([
                "e_name" : event.event_name!,
                "e_location":[
                    "name":event.event_location.name!,
                    "lat":event.event_location.lat!,
                    "lng":event.event_location.lng!
                ],
                "e_desc":event.description!,
                "e_datetime":event.datetime!,
                
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                        DispatchQueue.main.async {
                            completion("Data updated error",false)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion("Data updated successfully",false)
                        }
                    }
            }
            
        }else {
            
            Fbc.shared.collection("events").document(event.eventId!).updateData([
                "e_name" : event.event_name!,
                "e_location":[
                    "name":event.event_location.name!,
                    "lat":event.event_location.lat!,
                    "lng":event.event_location.lng!
                ],
                "e_desc":event.description!,
                "e_datetime":event.datetime!,
                "e_image":event.imageURL!
                
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                    DispatchQueue.main.async {
                        completion("Data updated error",false)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion("Data updated successfully",false)
                    }
                }
            }
        }
        
    }
    
    func updateEventCore(event:Event ,completion:@escaping(Bool)->()){
        if event.image == nil {
            self.updateSingleEvent(event: event){ msg,success in
                DispatchQueue.main.async {
                    completion(success)
                }
            }
        }else {
            FirebaseStorageService.uploadImages(event.image!, email: "", type: .Event) { (url
                , Bool) in
                if url != ""  {
                    event.imageURL = url
                }
                
                self.updateSingleEvent(event: event){ msg,success in
                    DispatchQueue.main.async {
                        completion(success)
                    }
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
                    
                    let dict = document.data()["e_location"] as? [String: AnyObject]
                    
                    
                    events.append(Event(event: document.data()["e_name"] as! String, e_location: Location(name: dict!["name"] as? String, lat: dict!["lat"] as? Double,lng : dict!["lng"] as? Double), desc: document.data()["e_desc"] as! String, date_time: document.data()["e_datetime"] as! String, eID :document.documentID ,userId: document.data()["userId"] as! String,imgurl: document.data()["e_image"] as! String))
                    
                }
                
                DispatchQueue.main.async {
                    completion(events)
                }
                
            }
        }
    }
    //    func goingNotGoingToSingleEvent(eventId :String,userId :String,completion: @escaping(Bool)->())  {
    //        Fbc.shared.collection("events").document(eventId).collection("likes").addDocument(data: [
    //            "user": userId,
    //            "time" : "\(Date())"
    //
    //        ]) { (Error) in
    //
    //            if (Error == nil) {
    //                completion(true)
    //            }else{
    //                completion(false)
    //            }
    //        }
    //    }
    
    func goingNotGoingToSingleEvent(eventId :String,userId :String,completion: @escaping(Bool)->()){
        Fbc.shared.collection("events").document(eventId).collection("likes").whereField("user", isEqualTo: def.value(forKey: "userID")).getDocuments { (querySnapshot, err
            ) in
            if let err = err {
                print("Error getting documents: \(err)")
                // completion(false)
            } else {
                if(querySnapshot!.documents.count>0) {
                    for document in querySnapshot!.documents {
                        document.reference.delete()
                    }
                    
                    completion(true)
                }else{
                    Fbc.shared.collection("events").document(eventId).collection("likes").addDocument(data: [
                        "user": userId,
                        "time" : "\(Date())"
                        
                    ]) { (Error) in
                        
                        if (Error == nil) {
                            print("added")
                            //                            completion(true)
                        }else{
                            print("not added")
                            //completion(false)
                        }
                    }
                    
                    completion(false)
                }
                
                
            }
        }
    }
    func commentToSingleEvent(eventId :String,comment: String)  {
        
        Fbc.shared.collection("events").document(eventId).collection("comments").addDocument(data: [
            "user": def.value(forKey: "userID") as! String,
            "comment" : comment,
            "datetime" : "\(Date())"
            
        ]) { (Error) in
            
            if (Error == nil) {
                print("Comment added")
            }
        }
    }
    func checkIfUserGoingNotGoingToAnEvent(eventId : String,completion :@escaping(Bool)->()){
        
        Fbc.shared.collection("events").document(eventId).collection("likes").whereField("user", isEqualTo: def.value(forKey: "userID") as! String).addSnapshotListener{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                if(querySnapshot?.documents.count as! Int > 0){
                    // print("hi you liked")
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }else{
                    
                    // print("hi you dis liked")
                    
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }
        }
    }
    func getGoingCountForEachEvent(eventId : String,completion :@escaping(Int)->()){
        Fbc.shared.collection("events").document(eventId).collection("likes").addSnapshotListener{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if((querySnapshot?.documents.count)!>0){
                    DispatchQueue.main.async {
                        completion((querySnapshot?.documents.count)!)
                    }
                }else{
                    
                    DispatchQueue.main.async {
                        completion(0)
                    }
                }
            }
        }
    }
    func getUserProfile(userId : String,completion :@escaping(User)->()){
        Fbc.settings.isPersistenceEnabled = false
        Fbc.shared.collection("users").document(userId).addSnapshotListener{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if((querySnapshot?.data()) != nil){
                    var data = querySnapshot?.data()!
                    let user = User(emails: data!["email"] as! String, nicknames: data!["nickname"] as! String, fullnames: data!["name"] as! String, images: data!["profile_image_url"] as! String)
                    DispatchQueue.main.async {
                        completion(user)
                    }
                }else{
                    
                    
                }
            }
        }
    }
    
    func fetchAllEventsBelongsToUser(userId : String,completion :@escaping([Event])->())  {
        Fbc.settings.isPersistenceEnabled = false
        var events :[Event] = [Event]()
        Fbc.shared.collection("events").whereField("userId", isEqualTo: userId).addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                events.removeAll()
                
                for document in querySnapshot!.documents {
                    let dict = document.data()["e_location"] as? [String: AnyObject]
                    
                    
                    events.append(Event(event: document.data()["e_name"] as! String, e_location: Location(name: dict!["name"] as? String, lat: dict!["lat"] as? Double,lng : dict!["lng"] as? Double), desc: document.data()["e_desc"] as! String, date_time: document.data()["e_datetime"] as! String, eID :document.documentID ,userId: document.data()["userId"] as! String,imgurl: document.data()["e_image"] as! String))
                    
                }
                
                DispatchQueue.main.async {
                    completion(events)
                }
                
            }
        }
    }
    
    func fetchAllCommentsBelongsToEvent(eventID :String,completion :@escaping([Comment])->()){
        Fbc.settings.isPersistenceEnabled = false
        var comments :[Comment] = [Comment]()
        Fbc.shared.collection("events").document(eventID).collection("comments").addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                comments.removeAll()
                
                for document in querySnapshot!.documents {
                   comments.append(Comment(user: document.data()["user"] as! String, comment:  document.data()["comment"] as! String, time: document.data()["datetime"] as! String))
                
                }
                
                DispatchQueue.main.async {
                    completion(comments)
                }
                
            }
        }
        
    }
}
