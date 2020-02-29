//
//  SingleEventViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 17/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit

class SingleEventViewController: UIViewController {

     var eventLViewModel : EventListViewModel!
    
    @IBOutlet weak var txtEventName: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       self.txtEventName.text = eventLViewModel.event_name!
    }
    
    @IBAction func btnClose(_ sender: Any) {
        
      dismiss(animated: true, completion: nil)
    
    }
    
}
