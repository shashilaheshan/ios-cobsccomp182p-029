//
//  EditEventViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 17/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher
import RxCocoa
import LocationPickerViewController

class EditEventViewController: UIViewController {
    
     var eventLViewModel : EventListViewModel!
     var dateFormatter = DateFormatter()

    @IBOutlet weak var btnEditEvent: UiButtonCustom!
    @IBOutlet weak var txtEventName: UICustomTextField!
    @IBOutlet weak var txtEventLocation: UICustomTextField!
    @IBOutlet weak var txtEventdescription: UICustomTextField!
    @IBOutlet weak var txtEventDateTime: UICustomTextField!
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var btnSelectLocation: UiButtonCustom!
     var keyBOb :KeyboardListeners!
    var is_image_picked:Bool = false
    var imagePicker : UIImagePickerController!
    
    @IBOutlet weak var pickerEventDate: UIDatePicker!
    let disposeBag =  DisposeBag()
     var location:Location!
    
     var eventViewModel : EventViewModel! = EventViewModel()
    
    override func viewDidLoad() {
          super.viewDidLoad()
        
         self.keyBOb = KeyboardListeners(view: self)
        
          self.setupView()
        
    }
    @IBAction func btnSelectLocation(_ sender: Any) {
        let locationPicker = LocationPicker()
        locationPicker.pickCompletion = { (pickedLocationItem) in
            // Do something with the location the user picked.
            if (pickedLocationItem.formattedAddressString != nil)  {
                self.txtEventLocation.text = pickedLocationItem.formattedAddressString
                self.location = Location(name:  pickedLocationItem.formattedAddressString, lat: pickedLocationItem.coordinate?.latitude, lng: pickedLocationItem.coordinate?.longitude)
            }
            
            
        }
        locationPicker.addBarButtons()
        // Call this method to add a done and a cancel button to navigation bar.
        
        let navigationController = UINavigationController(rootViewController: locationPicker)
        present(navigationController, animated: true, completion: nil)
    }
    @IBAction func selectEventImage(_ sender: Any) {
        let alert = UIAlertController(title: "Select source", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
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
    
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   @IBAction func btnEditEvent(_ sender: Any) {
   
        let img:UIImage!

        if is_image_picked {
            img = imgEvent.image!
        }else{
            img = nil
        }
    
         dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    
         let dateString = dateFormatter.string(from: pickerEventDate.date)

         let alert = ShowAlert.showAlertMessage(title: "Please wait..", message: "Data is updaing..", type: .Success, vc: self)
    

    self.eventViewModel = EventViewModel(eventname: self.txtEventName.text ?? "", eventlocaton: self.location == nil ? self.eventLViewModel.event_location : self.location, desc: self.txtEventdescription.text ?? "", date_time: dateString ?? "", eID: self.eventLViewModel.event_id!, eventImage: img, imgURL: "")

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
