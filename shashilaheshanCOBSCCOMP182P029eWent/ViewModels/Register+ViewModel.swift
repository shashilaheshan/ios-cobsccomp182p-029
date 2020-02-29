//
//  Register+ViewModel.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import RxSwift
import UIKit
protocol RegisterViewModelDelegate {
    
    func didUserRegistered(success: Bool)
}
class RegisterViewModel {
    
    var email : String!
    var nickName :String!
    var fullName :String!
    var password :String!
    var batch :String!
    var image :UIImage
    var image_url :String!
    
    private let authDataService : AuthDataService = AuthDataService()
    
     var registerViewModelDelegate : RegisterViewModelDelegate?
    
    private let is_loading = Variable(false)
    var isLoading :Observable<Bool>{
        return is_loading.asObservable()
    }
    
    init(e_mail :String,n_name :String,f_name :String,p_word :String,btch :String, image : UIImage,image_url: String) {
        
        self.email = e_mail
        self.nickName = n_name
        self.fullName = f_name
        self.password = p_word
        self.batch = btch
        self.image = image
        self.image_url = image_url
        
    }
    func registerUser()  {
        self.is_loading.value = true
        self.authDataService.registerUser(user: User(rvm: self)) {suceess ,loading  in
             self.registerViewModelDelegate?.didUserRegistered(success: suceess)
             self.is_loading.value = loading
             
        }
    }
}
