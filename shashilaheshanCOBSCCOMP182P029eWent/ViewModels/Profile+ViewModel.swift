//
//  Profile+ViewModel.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 14/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation

class ProfileViewModel {
    var email :String?
    var f_name :String?
    var batch :String?
    let profileService : ProfileDataService = ProfileDataService()
    init() {
        
    }
    init(mail : String,fname :String,batc :String) {
        
        self.email = mail
        self.f_name = fname
        self.batch = batc
        
    }
   
    func saveProfileInfo(profileD : Profile)  {
//        self.profileService.saveProfileData(profile: profileD)
        
        self.profileService.getProfileData { profile in
            print(profile)
        }
        
    }
    
    func getProfileInfo()  {
        //        self.profileService.saveProfileData(profile: profileD)
        
        self.profileService.getProfileData { profile in
            print(profile.email!)
        }
        
    }
    
    
}
