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
    
    @IBOutlet weak var btnCommiunity: UiButtonCustom!
    @IBOutlet weak var txtLikeCount: UILabel!
    
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var txtUsername: UILabel!
    
    @IBOutlet weak var txtEventTime: UILabel!
    
    @IBOutlet weak var btnLocation: UiButtonCustom!
    
    @IBOutlet weak var btnEditEvent: UiButtonCustom!
    
    @IBOutlet weak var imgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.imgPost.applyshadowWithCorner(containerView: self.imgView, cornerRadious: 10)
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 2
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowRadius = 10
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
    
}
