//
//  FirebaseStorageService.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 28/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
enum UploadType {
    case Profile
    case Event
}

class FirebaseStorageService {
    
    static func uploadImages(_ image : UIImage,email :String,type:UploadType ,completion :@escaping (String,Bool)->()){
        
        guard let imageToUpload = image.jpegData(compressionQuality: 0.75) else {return}
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        switch type {
        case .Profile:
            let stRef = Fbs.shared.child("users/\(email)")
            stRef.putData(imageToUpload, metadata: metaData) {[ self] metaData, Error in
                
                
                if metaData != nil , Error == nil {
                    stRef.downloadURL(completion: { (url, error) in
                        if error != nil {
                            completion("",false);
                            return
                        } else {
                            completion(url?.absoluteString ?? UtilsApp.default_image_profile ,true);
                        }
                    })
                }else {
                    completion("",false);
                }
            }
        case .Event:
            let stRef = Fbs.shared.child("events/\(UUID().uuidString)")
            stRef.putData(imageToUpload, metadata: metaData) {[ self] metaData, Error in
                
                
                if metaData != nil , Error == nil {
                    stRef.downloadURL(completion: { (url, error) in
                        if error != nil {
                            
                            completion("",false);
                            return
                        } else {
                            completion(url?.absoluteString ?? UtilsApp.default_event_image ,true);
                        }
                    })
                }else {
                   
                    completion("",false);
                }
            }
            
            
        }
        
        
        
    }
}
