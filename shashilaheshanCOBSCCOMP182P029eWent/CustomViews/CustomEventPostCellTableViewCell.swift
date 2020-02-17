//
//  CustomEventPostCellTableViewCell.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 13/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit

class CustomEventPostCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgPost: UIImageView!
    
    @IBOutlet weak var btnLikeEvent: UIButton!
    
    @IBOutlet weak var txtEventDesction: UILabel!
    
    @IBOutlet weak var btnCommentEvent: UIButton!
    
    @IBOutlet weak var btnShareEvent: UIButton!
    
    @IBOutlet weak var txtLikeCount: UILabel!
    
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var txtUsername: UILabel!
    
    @IBOutlet weak var txtEventTime: UILabel!
    
    @IBOutlet weak var btnLocation: UiButtonCustom!
    
    @IBOutlet weak var btnEditEvent: UiButtonCustom!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
