//
//  OfflineViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 1/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import Lottie


class OfflineViewController: UIViewController {
    
    let network = NetworkManager.sharedInstance
    
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnimationController.playAnimation(aV: animationView, name: "network-error")
        network.reachability.whenReachable = { reachability in
            print(reachability)
            self.showMainController()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func showMainController() -> Void {
       
        DispatchQueue.main.async {
             print("connected")
            self.performSegue(withIdentifier: "MainController", sender: self)
        }
    }
}
