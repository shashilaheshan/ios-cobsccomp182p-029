//
//  EventProtocolHandler.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 26/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
extension EventPostViewController : EventViewModelDelegate,ProfileViewModelDelegate,SetupViewProtocol{
    func setupView() {
        let network = NetworkManager.sharedInstance
        network.reachability.whenUnreachable = { reachability in
            self.showOfflinePage()
        }
        self.eventViewModel.eventViewModelDelegate = self
        
        self.profileViewModel.profileViewModelDelegate = self
        
        self.authViewModel.getAuthenticatedUser { (authed) in
            self.authedUser = authed
            
            if(authed){
                
                self.btnAddEvent.isHidden = false
            }else{
                self.btnAddEvent.isHidden = true
            }
            
            
        }
        
        self.eventViewModel.fetchAllEvents()
        self.pullToRefresh()
    }
    
    private func showOfflinePage() -> Void {
        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier: "NetworkUnavailable", sender: self)
        }
    }
    func pullToRefresh(){
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleTopRefresh(_:)), for: .valueChanged )
        refresh.tintColor = UIColor.black
        self.postsTableView.addSubview(refresh)
        
    }
    
    
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
extension EventAddViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate,SetupViewProtocol{
    func setupView() {
        
        self.imagePicker = UIImagePickerController()
        
        self.imagePicker.allowsEditing = true
        
        
        
        self.imagePicker.delegate = self
        
        self.keyBOb.setupKeyboardObservers()
        
        self.imgEvent.layer.cornerRadius = 10
        
        
        _ = eventName.rx.text.map {$0 ?? ""}.bind(to: self.eventViewModel.eventTxt)
        _ = eventDesc.rx.text.map {$0 ?? ""}.bind(to: self.eventViewModel.eventDescTxt)
       
        
        _ = self.eventViewModel.isValid.bind(to: self.btnAddEvent.rx.isEnabled)
        
        self.eventViewModel.isValid.subscribe(onNext : { isValid in
            if(isValid) {
                UIView.animate(withDuration: 1.0) {
                    self.btnAddEvent.layer.backgroundColor =  UIColor.black.cgColor
                    
                }
                
            }else{
                UIView.animate(withDuration: 1.0) {
                    self.btnAddEvent.layer.backgroundColor =  UIColor.red.cgColor
                    
                }
            }
            
            
        })
    }
    
    
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
extension EditEventViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate,SetupViewProtocol{
    func setupView() {
        self.imagePicker = UIImagePickerController()
        
        self.imagePicker.allowsEditing = true
        
        
        self.imagePicker.delegate = self
        
        self.keyBOb.setupKeyboardObservers()
        
        
        txtEventName.text = self.eventLViewModel.event_name!
        
        txtEventLocation.text = self.eventLViewModel.event_location.name!
        
        txtEventdescription.text = self.eventLViewModel.description!
        
        let dateString = self.eventLViewModel.datetime!
        
        
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        
        let date = dateFormatter.date(from: dateString)
        
        pickerEventDate.setDate(date!, animated: true)
        
        
        self.imgEvent.kf.indicatorType = .activity
        self.imgEvent.kf.setImage(
            with:  URL(string:self.eventLViewModel.image!),
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
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imgEvent.image = pickedImage
            self.is_image_picked = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}
extension SingleEventViewController: SetupViewProtocol,CommentViewModelDelegate {
    func didFinishFetchingComments(comments: [Comment]) {
      self.commentListViewModel.populateComments(_comments: comments)
        
        self.commentTableView.reloadData()
    }
    
    func setupView() {
        self.txtEventName.text = eventLViewModel.event_name!
        self.txtLocation.text = eventLViewModel.event_location.name!
        self.txtDescription.text = "\(self.eventLViewModel.description!) posted by \(self.eventLViewModel.userId!) @ \(self.eventLViewModel.datetime!) # \(self.eventLViewModel.event_location.name!)"
        
        self.imgEvent.kf.setImage(
            with:  URL(string:eventLViewModel.image!),
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            
        }
        self.imgEvent.layer.cornerRadius = 10
    }
    
    
}
