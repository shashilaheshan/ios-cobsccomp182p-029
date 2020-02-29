//
//  Profile+ViewModel.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 14/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
protocol ProfileViewModelDelegate {
    func didFinishedFetchingUserProfile(user : User,cell : CustomEventPostCellTableViewCell)
}
protocol SingleProfileViewModelDelegate{
     func didFinishedFetchingProfile(profile : Profile)
    func didFinishSingleUserEventsFetch(events : [Event])
}
class ProfileViewModel {
    var email :String?
    var f_name :String?
    var batch :String?
    let profileService : ProfileDataService = ProfileDataService()
    
    let eventDataService : EventDataService =  EventDataService()
    
    var profileViewModelDelegate : ProfileViewModelDelegate?
    
    var singleProfileViewModelDelegate : SingleProfileViewModelDelegate?
    
    init() {
        
    }
    init(mail : String,fname :String,batc :String) {
        
        self.email = mail
        self.f_name = fname
        self.batch = batc
        
    }
   
//    func saveProfileInfo(profileD : Profile)  {
//        
//        self.profileService.getProfileData { profile in
//            print(profile)
//        }
//        
//    }
    
    func getProfileInfo(userId: String,cell:CustomEventPostCellTableViewCell)  {
       
        self.eventDataService.getUserProfile(userId: userId ) { profile in
           
            self.profileViewModelDelegate?.didFinishedFetchingUserProfile(user: profile,cell: cell)
        }
        
    }
    
    func getProfileInfoForSingleUser(userId: String)  {
        self.profileService.getProfileData(email:  userId ) { profile in
            
            self.singleProfileViewModelDelegate?.didFinishedFetchingProfile(profile: profile)
        }
    }
    
    func getEventsBelongsToSingleUser(userId :String)  {
        self.eventDataService.fetchAllEventsBelongsToUser(userId: userId) { events
             in
            self.singleProfileViewModelDelegate?.didFinishSingleUserEventsFetch(events: events)
        }
    }
    
    
}
