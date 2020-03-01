//
//  GuestureTabBar.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 13/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import RxSwift

class GuestureTabBar: UITabBarController {

    var authViewModel = AuthViewModel()
    let network = NetworkManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network.reachability.whenUnreachable = { reachability in
            self.showOfflinePage()
        }
        self.authViewModel.getAuthenticatedUser { (authed) in
            if(authed){
               
                let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
                let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
                leftSwipe.direction = .left
                rightSwipe.direction = .right
                self.view.addGestureRecognizer(leftSwipe)
                self.view.addGestureRecognizer(rightSwipe)
            }else{
              //  print("hooooo")
                 self.tabBar.isHidden = true
                
            }
            
        }
       
       
    }
    
    private func showOfflinePage() -> Void {
       
        DispatchQueue.main.async {
          
            self.performSegue(withIdentifier: "NetworkUnavailable", sender: self)
        }
    }
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if sender.direction == .left {
            self.selectedIndex += 1
        }
        if sender.direction == .right {
            self.selectedIndex -= 1
        }
    }
    

}
