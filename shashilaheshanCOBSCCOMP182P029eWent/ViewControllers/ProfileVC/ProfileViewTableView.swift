

import UIKit
import Kingfisher

class TableViewController: UITableViewController {
    
    @IBOutlet var singleUserPosts: UITableView!
    
    @IBOutlet weak var imgUser: UIImageView!
    
    var Headerview : UIView!
    var NewHeaderLayer : CAShapeLayer!
    
    @IBOutlet weak var btnUsername: UiButtonCustom!
    @IBOutlet weak var txtProfileName: UILabel!
    var eventLViewModel : EventListViewModel!
    var profileViewModel : ProfileViewModel! = ProfileViewModel()
     let Headerheight : CGFloat = 300
     let Headercut : CGFloat = 50
    
    var eventViewModel : EventViewModel = EventViewModel()
    
    var eventsListViewModel : EventsListViewModel = EventsListViewModel()
   
    @IBAction func closeProfileScreen(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UpdateView()
        
        //self.txtProfileName.text = eventLViewModel.userId!
        self.btnUsername.titleText = eventLViewModel.userId!
        self.profileViewModel.singleProfileViewModelDelegate = self
        
        self.profileViewModel.getProfileInfoForSingleUser(userId: eventLViewModel.userId!)
        self.profileViewModel.getEventsBelongsToSingleUser(userId: eventLViewModel.userId!)
    }
    
}
