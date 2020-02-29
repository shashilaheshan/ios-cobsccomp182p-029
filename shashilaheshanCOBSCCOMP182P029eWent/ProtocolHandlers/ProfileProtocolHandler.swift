//
//  ProfileProtocolHandler.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 28/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit
extension TableViewController : SingleProfileViewModelDelegate  {
    
    
    func didFinishSingleUserEventsFetch(events: [Event]) {
        self.eventsListViewModel.populateEvents(_events: events)
        
      
        
        self.singleUserPosts.reloadData()
    }
    
    func didFinishedFetchingProfile(profile: Profile) {
      
       imgUser.kf.indicatorType = .activity
       imgUser.kf.setImage(
            with:  URL(string:profile.image!),
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
           // self.addBlurArea(area: self.view.frame, style: UIBlurEffect.Style.dark)

        }
    }
    func addBlurArea(area: CGRect, style: UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: effect)
        
        let container = UIView(frame: area)
        blurView.frame = CGRect(x: 0, y: 0, width: area.width, height: area.height)
        container.addSubview(blurView)
        container.alpha = 0.8
        self.view.insertSubview(container, at: 1)
    }
    func UpdateView() {
        tableView.backgroundColor = UIColor.white
        Headerview = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(Headerview)
        
        NewHeaderLayer = CAShapeLayer()
       // NewHeaderLayer.fillColor = UIColor(white: 1.0, alpha: 200/180) as! CGColor
        Headerview.backgroundColor = UIColor(white: 1.0, alpha: 200/180)
        Headerview.layer.mask = NewHeaderLayer
        
        
        let newheight = Headerheight - Headercut / 2
        tableView.contentInset = UIEdgeInsets(top: newheight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newheight)
        
        self.Setupnewview()
    }
    func Setupnewview() {
        let newheight = Headerheight - Headercut / 2
        var getheaderframe = CGRect(x: 0, y: -newheight, width: tableView.bounds.width, height: Headerheight)
        if tableView.contentOffset.y < newheight
        {
            getheaderframe.origin.y = tableView.contentOffset.y
            getheaderframe.size.height = -tableView.contentOffset.y + Headercut / 2
        }
        
        Headerview.frame = getheaderframe
        let cutdirection = UIBezierPath()
        cutdirection.move(to: CGPoint(x: 0, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: getheaderframe.height))
        cutdirection.addLine(to: CGPoint(x: 0, y: getheaderframe.height - Headercut))
        NewHeaderLayer.path = cutdirection.cgPath
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.singleUserPosts.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.Setupnewview()
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Tableview Methods
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 272
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsListViewModel.eventsListViewModel.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = singleUserPosts.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.DateLabel.text = self.eventsListViewModel.eventsListViewModel[indexPath.row].datetime!
        cell.TutorialName.text = self.eventsListViewModel.eventsListViewModel[indexPath.row].event_name!
        cell.Profileimage.kf.indicatorType = .activity
        cell.Profileimage.kf.setImage(
            with:  URL(string:self.eventsListViewModel.eventsListViewModel[indexPath.row].image!),
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            
        }
     cell.Profileimage.layer.cornerRadius = 20
        return cell
    }
}
