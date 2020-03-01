//
//  SingleEventViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 17/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import Kingfisher
import CoreLocation
import MapKit

class SingleEventViewController: UIViewController {

     var eventLViewModel : EventListViewModel!
    
    var commentViewModel : CommentViewModel = CommentViewModel()
    
    var commentListViewModel : CommentsListViewModel = CommentsListViewModel()
    
    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var imgEvent: UIImageView!
    
    @IBOutlet weak var txtEventName: UILabel!
    
    @IBOutlet weak var txtLocation: UILabel!
    
    @IBOutlet weak var txtDescription: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupView()
        
        self.commentViewModel.commentVMDelegate = self
        
        self.commentViewModel.fetchAllComments(eventID: self.eventLViewModel.event_id!)
    }
    
    @IBAction func btnClose(_ sender: Any) {
        
      dismiss(animated: true, completion: nil)
    
    }
    
    @IBAction func btnGetLocation(_ sender: Any) {
        
        MapLocation.openMapForPlace(lat:self.eventLViewModel.event_location.lat!,lng: self.eventLViewModel.event_location.lng!)
    }
    
}
extension SingleEventViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentListViewModel.commentsListViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.commentTableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! CommentCell
        cell.imgUser.kf.setImage(
            with: URL(string:"https://ww2.mendix.com/rs/729-ZYH-434/images/profile-pica-willem-200x200-round.png"),
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            
        }
        cell.txtComment.text = self.commentListViewModel.commentsListViewModel[indexPath.row].comment!
        cell.txttime.text = self.commentListViewModel.commentsListViewModel[indexPath.row].datetime!
         cell.txtUser.text = self.commentListViewModel.commentsListViewModel[indexPath.row].user!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete
                {
                    self.commentListViewModel.commentsListViewModel.remove(at: indexPath.row)
                    self.commentTableView.reloadData()
                }
    }

    
}
