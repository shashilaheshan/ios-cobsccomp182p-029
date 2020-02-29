//
//  RegisterProtocolHandler.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 26/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
extension RegisterVC : RegisterViewModelDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func didUserRegistered(success: Bool) {
        
        if success {
            self.dismiss(animated: true, completion: nil)
        }else{
            
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imgProfilePicture.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}
