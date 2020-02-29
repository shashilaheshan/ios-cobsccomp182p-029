//
//  EditEventViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 17/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import RxSwift

class EditEventViewController: UIViewController {
    
     var eventLViewModel : EventListViewModel!

    @IBOutlet weak var txtEventName: UICustomTextField!
    @IBOutlet weak var txtEventLocation: UICustomTextField!
    @IBOutlet weak var txtEventdescription: UICustomTextField!
    @IBOutlet weak var txtEventDateTime: UICustomTextField!
    @IBOutlet weak var txtEventImage: UICustomTextField!
    let disposeBag =  DisposeBag()
    
    private var eventViewModel : EventViewModel!
    
    override func viewDidLoad() {
          super.viewDidLoad()
        
          txtEventName.text = self.eventLViewModel.event_name!
        
          txtEventLocation.text = self.eventLViewModel.event_location!
        
          txtEventdescription.text = self.eventLViewModel.description!
        
          txtEventDateTime.text = self.eventLViewModel.datetime!
        
          txtEventImage.text = self.eventLViewModel.image!

    }
    
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnEditEvent(_ sender: Any) {
        var alert: UIAlertView = UIAlertView(title: "Updating", message: "Please wait...", delegate: nil, cancelButtonTitle: "Cancel");
        
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x:50, y:10, width:37, height:37))
        loadingIndicator.center = self.view.center;
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.setValue(loadingIndicator, forKey: "accessoryView")
        loadingIndicator.startAnimating()
        
//        self.eventViewModel = EventViewModel(eventname: self.txtEventName.text ?? "", eventlocaton: self.txtEventLocation.text ?? "", desc: self.txtEventdescription.text ?? "", date_time: self.txtEventDateTime.text ?? "", img: self.txtEventImage.text ?? "",eID: self.eventLViewModel.event_id!)
        
        self.eventViewModel.isLoading.subscribe(onNext: {
            [weak self] loading in
            
            if(loading){
                alert.show();
            }else {
                alert.dismiss(withClickedButtonIndex: 0, animated: true)
                
            }
        }).disposed(by: disposeBag)
        
        
        self.eventViewModel.editEventData()
    }
}
