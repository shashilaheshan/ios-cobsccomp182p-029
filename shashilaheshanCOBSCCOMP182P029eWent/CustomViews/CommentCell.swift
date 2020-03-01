//
//  CommentCell.swift
//  shashilaheshanCOBSCCOMP182P029eWent
//
//  Created by Shashila Heshan on 1/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//


import UIKit

class CommentCell: UITableViewCell {
   
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var txtUser: UILabel!
    @IBOutlet weak var txtComment: UILabel!
    @IBOutlet weak var txttime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

