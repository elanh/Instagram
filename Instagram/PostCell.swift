//
//  PostCell.swift
//  Instagram
//
//  Created by Elan Halpern on 6/28/17.
//  Copyright © 2017 Elan Halpern. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class PostCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var profilePictureButton: UIButton!
    
    
    @IBOutlet weak var profilePictureView: PFImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
