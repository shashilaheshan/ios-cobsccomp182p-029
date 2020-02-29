//
//  SingleEventViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 17/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit

class SingleProfileVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tblUSerEvents: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblUSerEvents.dequeueReusableCell(withIdentifier: "userevents", for: indexPath)
        return cell
    }
    
    
     var eventLViewModel : EventListViewModel!
    var profileViewModel : ProfileViewModel! = ProfileViewModel()
    
    
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    //@IBOutlet weak var imgView: UIView!
   // @IBOutlet weak var txtEventName: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        DispatchQueue.main.async {
           // self.imgProfile.applyshadowWithCorner(containerView: self.imgView, cornerRadious: 10)
        }
        
       // self.txtEventName.text = eventLViewModel.userId!
     
        
        profileViewModel.singleProfileViewModelDelegate = self
        
        self.profileViewModel.getProfileInfoForSingleUser(userId: eventLViewModel.userId!)
    }
    
    @IBAction func btnClose(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}

