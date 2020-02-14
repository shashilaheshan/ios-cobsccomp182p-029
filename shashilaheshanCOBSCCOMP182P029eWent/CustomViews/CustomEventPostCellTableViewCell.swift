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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
