//
//  EventProtocolHandler.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 26/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
extension EventPostViewController : EventViewModelDelegate,ProfileViewModelDelegate{
    
    func getLikeCountForEachEvent(count: Int, cell: CustomEventPostCellTableViewCell) {
        if(count>1000){
            let countVal:Double = Double(count/1000)
            
            cell.txtLikeCount.text = "\(countVal) K"
            
        }else {
            cell.txtLikeCount.text = "\(count)"
        }
        
        
    }
    
    
    func checkUserLikedToAnEvent(like: Bool, cell: CustomEventPostCellTableViewCell) {
        cell.btnLikeEvent.addTarget(self, action: #selector(goingNotGoingToSingleEvent(sender:)), for: .touchUpInside)
        if(like) {
            cell.btnLikeEvent.setImage(UIImage(named: "like"), for: UIControl.State.normal)
          
           
            
        }else {
            cell.btnLikeEvent.setImage(UIImage(named: "dislike"), for: UIControl.State.normal)
            
            
        }
        
    }
//    @objc func addNotGoing(sender: UIButton){
//        let selectedIndex = sender.tag
//
//        let eventId = self.eventsListViewModel.eventsListViewModel[selectedIndex].event_id!
//        let userID = self.eventsListViewModel.eventsListViewModel[selectedIndex].userId!
//      // print("not-going")
//        self.eventViewModel.notGoingSingleEvent(eventId: eventId,userId: userID){ success in
//            if(success) {
//                //print(success)
//            }
//
//        }
//
//    }
    
    @objc func goingNotGoingToSingleEvent(sender: UIButton){
        let selectedIndex = sender.tag
        
        let eventId = self.eventsListViewModel.eventsListViewModel[selectedIndex].event_id!
        let userID = self.eventsListViewModel.eventsListViewModel[selectedIndex].userId!
       // print("going")
      
        self.eventViewModel.goingNotGoingToSingleEvent(eventId: eventId,userId: userID){ success in
           
           // print(success)
        }
        
    }
    func didFinishedFetchingUserProfile(user: User, cell: CustomEventPostCellTableViewCell) {
        cell.txtUsername.text = user.fullName!
        cell.imgUser.kf.indicatorType = .activity
        cell.imgUser.kf.setImage(
            with:  URL(string:user.image_url!),
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            
        }
    }
    
    func didFinishFetchingEvents(events: [Event]) {
        self.eventsListViewModel.populateEvents(_events: events)
        
        self.postsTableView.reloadData()
    }
}
extension EventAddViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imgEvent.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}
