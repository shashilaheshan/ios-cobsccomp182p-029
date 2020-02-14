//
//  EventPostViewController.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 13/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit
import Kingfisher

class EventPostViewController: UIViewController {
var pullControl = UIRefreshControl()
    @IBOutlet weak var postsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pullToRefresh()

        // Do any additional setup after loading the view.
    }
    func pullToRefresh(){
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleTopRefresh(_:)), for: .valueChanged )
        refresh.tintColor = UIColor.black
        self.postsTableView.addSubview(refresh)
        
    }
    @objc func handleTopRefresh(_ sender:UIRefreshControl){
       // self.callAddressBookListApi(isLoaderRequired: false)
        print("refrshing data")
        sender.endRefreshing()
    }
   


}
extension EventPostViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10000
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.postsTableView.dequeueReusableCell(withIdentifier: "Event", for: indexPath) as! CustomEventPostCellTableViewCell
      
        let url = URL(string: "https://cdn.guidingtech.com/imager/assets/2019/06/227804/N-Best-The-Joker-HD-Wallpapers-That-You-Can-Download-4_4d470f76dc99e18ad75087b1b8410ea9.jpg?1559547498")

        
        cell.imgPost.kf.indicatorType = .activity
        cell.imgPost.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
               
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        cell.btnLikeEvent.tag = indexPath.row
        cell.btnLikeEvent.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func connected(sender: UIButton){
        let selectedIndex = sender.tag

        print(selectedIndex)
    }
}
