//
//  EventAddViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 16/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import LocationPickerViewController

class EventAddViewController: UIViewController {
    
    @IBOutlet weak var eventName: UICustomTextField!
    
    @IBOutlet weak var eventLocation: UICustomTextField!
    
    @IBOutlet weak var btnAddEvent: UiButtonCustom!
    
    @IBOutlet weak var eventDesc: UICustomTextField!
    
    @IBOutlet weak var pkrDateTime: UIDatePicker!
    
    @IBOutlet weak var eventImage: UICustomTextField!
    
    @IBOutlet weak var imgEvent: UIImageView!
    
     var eventViewModel : EventViewModel! = EventViewModel()
    
    let disposeBag =  DisposeBag()
    
    var imagePicker : UIImagePickerController!
    
    var location:Location!
    
     var keyBOb :KeyboardListeners!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           self.keyBOb = KeyboardListeners(view: self)
        
        self.setupView()

        
    }
    @IBAction func selectEventImg(_ sender: Any) {
        let alert = UIAlertController(title: "Select source", message: "Select image location", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "CAMERA", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "GALLERY", style: UIAlertAction.Style.default, handler:{(action:UIAlertAction!) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // We implement that function to get date string
    @objc func dateChanged(sender : UIDatePicker) {
       
        //print(strDate)
    }
    @IBAction func btnSetEventLocation(_ sender: Any) {
        let locationPicker = LocationPicker()
        locationPicker.pickCompletion = { (pickedLocationItem) in
            // Do something with the location the user picked.
            if (pickedLocationItem.formattedAddressString != nil)  {
                self.eventLocation.text = pickedLocationItem.formattedAddressString
                self.location = Location(name:  pickedLocationItem.formattedAddressString, lat: pickedLocationItem.coordinate?.latitude, lng: pickedLocationItem.coordinate?.longitude)
            }
            
            
        }
        locationPicker.addBarButtons()
        // Call this method to add a done and a cancel button to navigation bar.
        
        let navigationController = UINavigationController(rootViewController: locationPicker)
        present(navigationController, animated: true, completion: nil)
    }
    
    
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addEvent(_ sender: Any) {
       
    
        if self.imgEvent.image?.imageAsset != nil {
            if self.location != nil {
                let dateFormatr = DateFormatter()
                dateFormatr.dateFormat = "dd-MM-yyyy HH:mm:ss"
                let strDate = dateFormatr.string(from: (pkrDateTime?.date)!)
                let alert = ShowAlert.showAlertMessage(title: "Adding", message: "Event is adding please wait", type: .Success, vc: self)
                self.eventViewModel = EventViewModel(eventname: self.eventName.text ?? "", eventlocaton: self.location , desc: self.eventDesc.text ?? "", date_time: strDate ?? "",eID: "",eventImage: self.imgEvent.image!,imgURL: "")
                
                self.eventViewModel.isLoading.subscribe(onNext: {
                    [weak self] loading in
                    
                    if(loading){
                        alert.show();
                    }else {
                        alert.dismiss(withClickedButtonIndex: 0, animated: true)
                        // self!.dismiss(animated: true, completion: nil)
                        
                    }
                }).disposed(by: disposeBag)
                
                self.eventViewModel.saveEventData()
            }else{
                ShowAlert.showAlertMessage(title: "Error", message: "Please select Location", type: .Error, vc: self).show()
            }

            
        }else{

            ShowAlert.showAlertMessage(title: "Error", message: "Please select an Image", type: .Error, vc: self).show()
        }

        
        
    }
   
}
