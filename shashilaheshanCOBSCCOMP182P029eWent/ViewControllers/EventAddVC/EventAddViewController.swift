//
//  EventAddViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import RxSwift

class EventAddViewController: UIViewController {

    @IBOutlet weak var eventName: UICustomTextField!
    
    @IBOutlet weak var eventLocation: UICustomTextField!
    
    
    @IBOutlet weak var eventDesc: UICustomTextField!
    
    @IBOutlet weak var eventDatetime: UICustomTextField!
    
    
    @IBOutlet weak var eventImage: UICustomTextField!
    
    let disposeBag =  DisposeBag()
    
    private var eventViewModel : EventViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
   
    
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addEvent(_ sender: Any) {
        var alert: UIAlertView = UIAlertView(title: "Title", message: "Please wait...", delegate: nil, cancelButtonTitle: "Cancel");
        
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x:50, y:10, width:37, height:37))
        loadingIndicator.center = self.view.center;
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.setValue(loadingIndicator, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
       
        
        self.eventViewModel = EventViewModel(eventname: self.eventName.text ?? "", eventlocaton: self.eventLocation.text ?? "", desc: self.eventDesc.text ?? "", date_time: self.eventDatetime.text ?? "", img: self.eventImage.text ?? "")
        
        self.eventViewModel.isLoading.subscribe(onNext: {
            [weak self] loading in
            
            if(loading){
                 alert.show();
            }else {
                alert.dismiss(withClickedButtonIndex: 0, animated: true)
                
            }
        }).disposed(by: disposeBag)
        
        self.eventViewModel.saveEventData()
        
    }
}
