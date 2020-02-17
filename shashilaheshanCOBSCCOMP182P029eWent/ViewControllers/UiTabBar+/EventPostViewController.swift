//
//  EventPostViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 13/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import Kingfisher

class EventPostViewController: UIViewController {
    var pullControl = UIRefreshControl()
    
    let def = UserDefaults.standard
    
    @IBOutlet weak var postsTableView: UITableView!
    
    private let eventViewModel : EventViewModel = EventViewModel()
    
    private let eventsListViewModel : EventsListViewModel = EventsListViewModel()
    
    private let eventDataService : EventDataService = EventDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventDataService.fetchAllEvents { events in
            self.eventsListViewModel.populateEvents(_events: events)
            
            self.postsTableView.reloadData()
        }
        self.pullToRefresh()

        // Do any additional setup after loading the view.
    }
    func pullToRefresh(){
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleTopRefresh(_:)), for: .valueChanged )
        refresh.tintColor = UIColor.green
        self.postsTableView.addSubview(refresh)
        
    }
    @objc func handleTopRefresh(_ sender:UIRefreshControl){
       
        eventDataService.fetchAllEvents { events in
            self.eventsListViewModel.populateEvents(_events: events)
            self.postsTableView.reloadData()
            
        }
        sender.endRefreshing()
       
        
    }
   
}
extension EventPostViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsListViewModel.eventsListViewModel.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.postsTableView.dequeueReusableCell(withIdentifier: "Event", for: indexPath) as! CustomEventPostCellTableViewCell
      
        let url = URL(string: "https://cdn.guidingtech.com/imager/assets/2019/06/227804/N-Best-The-Joker-HD-Wallpapers-That-You-Can-Download-4_4d470f76dc99e18ad75087b1b8410ea9.jpg?1559547498")

        
        cell.imgPost.kf.indicatorType = .activity
        cell.imgPost.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
               
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
//            switch result {
//            case .success(let value):
//                print("")
//            case .failure(let error):
//                print("")
//            }
        }
        cell.txtUsername.text = self.eventsListViewModel.eventsListViewModel[indexPath.row].event_name!
        
        cell.txtEventTime.text = self.eventsListViewModel.eventsListViewModel[indexPath.row].datetime!
        
        cell.btnLocation.setTitle(self.eventsListViewModel.eventsListViewModel[indexPath.row].event_location!,for: .normal)
        
        if(def.value(forKey: "userID") as! String == self.eventsListViewModel.eventsListViewModel[indexPath.row].userId as! String) {
            cell.btnEditEvent.isHidden = false
            cell.btnEditEvent.isEnabled = true
        }else {
            cell.btnEditEvent.isHidden = true
            cell.btnEditEvent.isEnabled = false
        }
        
        cell.txtEventDesction.text = "\(self.eventsListViewModel.eventsListViewModel[indexPath.row].description!) posted by \(self.eventsListViewModel.eventsListViewModel[indexPath.row].event_name!) @ \(self.eventsListViewModel.eventsListViewModel[indexPath.row].datetime!) # \(self.eventsListViewModel.eventsListViewModel[indexPath.row].event_location!)"
        self.eventDataService.checkIfUserLikedToAnEvent(eventId: self.eventsListViewModel.eventsListViewModel[indexPath.row].event_id!){liked in
            if(liked) {
                cell.btnLikeEvent.setImage(UIImage(named: "like"), for: UIControl.State.normal)
               
            }else {
                cell.btnLikeEvent.setImage(UIImage(named: "dislike"), for: UIControl.State.normal)
            }
            
        }
        self.eventDataService.getLikeCountForEachEvent(eventId: self.eventsListViewModel.eventsListViewModel[indexPath.row].event_id!){count in
            if(count>1000){
                let countVal:Double = Double(count/1000)
                cell.txtLikeCount.text = "\(countVal) K"
            }else {
                
                cell.txtLikeCount.text = "\(count)"
            }
            
        }
        //cell.btnLikeEvent.setTitle(self.eventsListViewModel.eventsListViewModel[indexPath.row].event_name as! String, for: .normal)
        cell.btnLikeEvent.tag = indexPath.row
        cell.btnLikeEvent.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
         cell.btnCommentEvent.tag = indexPath.row
        cell.btnCommentEvent.addTarget(self, action: #selector(comment(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func connected(sender: UIButton){
        let selectedIndex = sender.tag
         print(selectedIndex)
        let eventId = self.eventsListViewModel.eventsListViewModel[selectedIndex].event_id!
        self.eventDataService.likeToSingleEvent(eventId: eventId)
    }
    @objc func comment(sender: UIButton){
        let selectedIndex = sender.tag
        print(selectedIndex)
        let eventIds = self.eventsListViewModel.eventsListViewModel[selectedIndex].event_id!
        let alertController = UIAlertController(title: "Add New Comment", message: "", preferredStyle: UIAlertController.Style.alert)
       
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let comment = alertController.textFields![0] as UITextField
            
           
            self.eventDataService.commentToSingleEvent(eventId: eventIds,comment :comment.text!)
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
}
