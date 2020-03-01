//
//  VideoViewcontroller.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 1/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import RxSwift
import GPVideoPlayer

class VideoViewController: UIViewController {
   
    
    @IBOutlet weak var tblVidel: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblVidel.reloadData()
      
    
    }
   
}

extension VideoViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VideoCell = self.tblVidel.dequeueReusableCell(withIdentifier: "video", for: indexPath) as! VideoCell
        if let player = GPVideoPlayer.initialize(with: cell.playerSubView.bounds) {
            player.isToShowPlaybackControls = true
            
            cell.playerSubView.addSubview(player)
            
            let url1 = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!
            //let videoFilePath = Bundle.main.path(forResource: "video", ofType: "mp4")
            //let url2 = URL(fileURLWithPath: videoFilePath!)
            
            player.loadVideos(with: [url1])
            player.isToShowPlaybackControls = true
            player.isMuted = true
            player.playVideo()
        }
        
        return cell
    }
    
    
}
