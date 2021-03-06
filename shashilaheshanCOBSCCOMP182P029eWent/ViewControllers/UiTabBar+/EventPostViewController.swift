//
//  EventPostViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 13/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import Kingfisher

class EventPostViewController: UIViewController,UIViewControllerTransitioningDelegate {
    let transition = CircularTransition()
    var pullControl = UIRefreshControl()
    
    let def = UserDefaults.standard
    var authedUser :Bool = false
    
    @IBOutlet weak var postsTableView: UITableView!
    
    var eventViewModel : EventViewModel = EventViewModel()
    
    var eventsListViewModel : EventsListViewModel = EventsListViewModel()
    
    @IBOutlet weak var btnAddEvent: UiButtonCustom!
    
    @IBOutlet weak var btnLoginForGuestUser: UiButtonCustom!
    
    var eventDataService : EventDataService = EventDataService()
    
    var profileViewModel : ProfileViewModel =  ProfileViewModel()
    
    var authViewModel :AuthViewModel =  AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
    }
    
    @IBAction func btnAddPostFab(_ sender: Any) {
        
        
    }
    @IBAction func btnLoginGuest(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        //transition.startingPoint = btnLogin.center
        transition.circleColor = Colors.green
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        //transition.startingPoint = btnLogin.center
        transition.circleColor = Colors.green
        
        return transition
    }
    
    @objc func handleTopRefresh(_ sender:UIRefreshControl){
        
        self.eventViewModel.fetchAllEvents()
        sender.endRefreshing()
        
    }
    
    @IBAction func btnAlert(_ sender: Any) {
        AlertView.instance.showAlert(title: "Notifications", message: "You have no notifications..", alertType: .success)
    }
}
extension EventPostViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsListViewModel.eventsListViewModel.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    fileprivate func hideAuthButtonForAuthUser(authed: Bool) {
        if (authed) {
            
            self.btnLoginForGuestUser.isEnabled = false
            self.btnLoginForGuestUser.isHidden = true
        } else{
            self.btnLoginForGuestUser.isEnabled = true
            self.btnLoginForGuestUser.isHidden = false
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        var cell :UITableViewCell!
        
      
        if(self.authedUser){
            hideAuthButtonForAuthUser(authed:true)
            cell =  self.generateAuthedUsereEventTableViewCells(tableView, cellForRowAt:indexPath )
        }else{
            hideAuthButtonForAuthUser(authed:false)
            cell =  self.generateGuestUserEventTableViewcells(tableView, cellForRowAt:indexPath )

        }

        
        return cell
    }
    
    @objc func opensingleView(tapGestureRecognizer: CustomTapGestureRecognizer){
        
        
        let eventVM = self.eventsListViewModel.eventsListViewModel[tapGestureRecognizer.index!]
        
        let eVC :SingleEventViewController = UIStoryboard(name: "EventView", bundle: nil).instantiateViewController(withIdentifier: "EventView_SB") as! SingleEventViewController
        eVC.transitioningDelegate = self
        
        eVC.eventLViewModel = eventVM
        
        self.present(eVC, animated: true, completion: nil)
        
    }
    
    
    
    
    @objc func editEvent(sender: UIButton){
        let selectedIndex = sender.tag
        
        let eventVM = self.eventsListViewModel.eventsListViewModel[selectedIndex]
        let eVC :EditEventViewController = UIStoryboard(name: "EditEvent", bundle: nil).instantiateViewController(withIdentifier: "EditEvent_SB") as! EditEventViewController
        eVC.transitioningDelegate = self
        
        eVC.eventLViewModel = eventVM
        
        self.present(eVC, animated: true, completion: nil)
        
    }
    
    @objc func openProfile(tapGestureRecognizer: CustomTapGestureRecognizer){
        let eventVM = self.eventsListViewModel.eventsListViewModel[tapGestureRecognizer.index!]
        
        let pVC :TableViewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileView_SB") as! TableViewController
        pVC.transitioningDelegate = self
        
        
        
        pVC.eventLViewModel = eventVM
        
        self.present(pVC, animated: true, completion: nil)
        
    }
    
    @objc func comment(sender: UIButton){
        let selectedIndex = sender.tag
        let eventIds = self.eventsListViewModel.eventsListViewModel[selectedIndex].event_id!
        let alertController = UIAlertController(title: "Add New Comment", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let comment = alertController.textFields![0] as UITextField
            
            self.eventViewModel.commentToSingleEvent(eventId: eventIds,comment :comment.text!)
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Your Comment"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    @objc func openLocation(sender: UIButton){
        let selectedIndex = sender.tag
        
        let event = self.eventsListViewModel.eventsListViewModel[selectedIndex]

        MapLocation.openMapForPlace(lat: event.event_location.lat!, lng: event.event_location.lng!)
        
    }
    
    func generateGuestUserEventTableViewcells(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        
        let cell = self.postsTableView.dequeueReusableCell(withIdentifier: "Event", for: indexPath) as! CustomEventPostCellTableViewCell
        
        let url = URL(string: "https://i.pinimg.com/originals/c2/f1/06/c2f106c6e9a04467067864f3ee103b7b.jpg")
        let url2 = URL(string: "https://i.pinimg.com/originals/ec/a8/9a/eca89af3c15d4e1fe509baac34517f25.jpg")
       
        cell.imgPost.kf.indicatorType = .activity
        cell.imgPost.kf.setImage(
            with: self.eventsListViewModel.eventsListViewModel[indexPath.row].image! == "" ?  url  :     URL(string:self.eventsListViewModel.eventsListViewModel[indexPath.row].image!),
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            
        }
        
        self.profileViewModel.getProfileInfo(userId: self.eventsListViewModel.eventsListViewModel[indexPath.row].userId!, cell: cell)
        
        
        cell.imgUser.layer.cornerRadius = 20
        
        cell.btnCommiunity.titleText = self.eventsListViewModel.eventsListViewModel[indexPath.row].datetime!
        
        
        
        cell.txtEventTime.text = self.eventsListViewModel.eventsListViewModel[indexPath.row].datetime!
        
        cell.btnLocation.setTitle(self.eventsListViewModel.eventsListViewModel[indexPath.row].event_location.name!,for: .normal)
        
        cell.btnEditEvent.isHidden = true
        
        
        cell.txtEventDesction.text = "\(self.eventsListViewModel.eventsListViewModel[indexPath.row].description!) posted by \(self.eventsListViewModel.eventsListViewModel[indexPath.row].event_name!) @ \(self.eventsListViewModel.eventsListViewModel[indexPath.row].datetime!) # \(self.eventsListViewModel.eventsListViewModel[indexPath.row].event_location!)"
        
        
        
        
        self.eventViewModel.getGoingCountForEachEvent(eventId: self.eventsListViewModel.eventsListViewModel[indexPath.row].event_id!,cell: cell)
        
        cell.imgPost.tag = indexPath.row
        
        let tapImage = CustomTapGestureRecognizer(target: self, action: #selector(opensingleView(tapGestureRecognizer:)))
        
        tapImage.index = indexPath.row
        
        
        cell.imgPost.addGestureRecognizer(tapImage)
        
        cell.imgPost.isUserInteractionEnabled = true
        
        let tapProfile = CustomTapGestureRecognizer(target: self, action: #selector(openProfile(tapGestureRecognizer:)))
        
        tapProfile.index = indexPath.row
        
        cell.imgUser.addGestureRecognizer(tapProfile)
        
        cell.imgUser.isUserInteractionEnabled = true
        
        cell.btnLikeEvent.tag = indexPath.row
        
        
        cell.btnLocation.tag = indexPath.row
        
        cell.btnLocation.addTarget(self, action: #selector(openLocation(sender:)), for: .touchUpInside)
        
        cell.btnLikeEvent.isHidden = true
        
        cell.btnShareEvent.isHidden = true
        
        cell.btnCommentEvent.isHidden = true
        
        cell.btnLikeEvent.isEnabled = false
        
        cell.btnShareEvent.isEnabled = false
        
        cell.btnCommentEvent.isEnabled = false
        
        cell.txtLikeCount.isHidden = true
        
        return cell
        
    }
    
    func generateAuthedUsereEventTableViewCells(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = self.postsTableView.dequeueReusableCell(withIdentifier: "Event", for: indexPath) as! CustomEventPostCellTableViewCell
        
        let url = URL(string: "https://i.pinimg.com/originals/c2/f1/06/c2f106c6e9a04467067864f3ee103b7b.jpg")
        let url2 = URL(string: "https://i.pinimg.com/originals/ec/a8/9a/eca89af3c15d4e1fe509baac34517f25.jpg")
        
        cell.imgPost.kf.indicatorType = .activity
        cell.imgPost.kf.setImage(
            with: self.eventsListViewModel.eventsListViewModel[indexPath.row].image! == "" ?  url  :     URL(string:self.eventsListViewModel.eventsListViewModel[indexPath.row].image!),
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            
        }
        
        self.profileViewModel.getProfileInfo(userId: self.eventsListViewModel.eventsListViewModel[indexPath.row].userId!, cell: cell)
        
        
        cell.imgUser.layer.cornerRadius = 20
        
        
        
        cell.txtEventTime.text = self.eventsListViewModel.eventsListViewModel[indexPath.row].datetime!
        cell.btnCommiunity.titleText = self.eventsListViewModel.eventsListViewModel[indexPath.row].datetime!
        
        cell.btnLocation.setTitle(self.eventsListViewModel.eventsListViewModel[indexPath.row].event_location.name!,for: .normal)
        
        if(def.value(forKey: "userID") as! String == self.eventsListViewModel.eventsListViewModel[indexPath.row].userId!) {
            cell.btnEditEvent.isHidden = false
            cell.btnEditEvent.isEnabled = true
            cell.btnEditEvent.tag = indexPath.row
            
            cell.btnEditEvent.addTarget(self, action: #selector(editEvent(sender:)), for: .touchUpInside)
        }else {
            cell.btnEditEvent.isHidden = true
            cell.btnEditEvent.isEnabled = false
        }
        
        
        
        cell.txtEventDesction.text = "\(self.eventsListViewModel.eventsListViewModel[indexPath.row].description!) posted by \(self.eventsListViewModel.eventsListViewModel[indexPath.row].event_name!) @ \(self.eventsListViewModel.eventsListViewModel[indexPath.row].datetime!) # \(self.eventsListViewModel.eventsListViewModel[indexPath.row].event_location.name!)"
        
        
        self.eventViewModel.checkIfUserGoingToAnEvent(eventId: self.eventsListViewModel.eventsListViewModel[indexPath.row].event_id!, cell: cell)
        //print(self.eventsListViewModel.eventsListViewModel[indexPath.row].event_id!)
        
        
        self.eventViewModel.getGoingCountForEachEvent(eventId: self.eventsListViewModel.eventsListViewModel[indexPath.row].event_id!,cell: cell)
        
        cell.imgPost.tag = indexPath.row
        
        let tapImage = CustomTapGestureRecognizer(target: self, action: #selector(opensingleView(tapGestureRecognizer:)))
        
        tapImage.index = indexPath.row
        
        
        cell.imgPost.addGestureRecognizer(tapImage)
        
        cell.imgPost.isUserInteractionEnabled = true
        
        let tapProfile = CustomTapGestureRecognizer(target: self, action: #selector(openProfile(tapGestureRecognizer:)))
        
        tapProfile.index = indexPath.row
        
        cell.imgUser.addGestureRecognizer(tapProfile)
        
        cell.imgUser.isUserInteractionEnabled = true
        
        cell.btnLikeEvent.tag = indexPath.row
        
        
        cell.btnLocation.tag = indexPath.row
        
        cell.btnLocation.addTarget(self, action: #selector(openLocation(sender:)), for: .touchUpInside)
        
        cell.btnCommentEvent.tag = indexPath.row
        
        cell.btnCommentEvent.addTarget(self, action: #selector(comment(sender:)), for: .touchUpInside)
        
        return cell
    }
}
class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var index: Int?
}

