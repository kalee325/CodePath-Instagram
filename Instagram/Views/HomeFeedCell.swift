//
//  HomeFeedCell.swift
//  Instagram
//
//  Created by Ka Lee on 9/21/18.
//  Copyright © 2018 Ka Lee. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeFeedCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var timePostLabel: UILabel!
    
    @IBOutlet weak var feedImageView: PFImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    var post: PFObject! {
        didSet {
            
            usernameLabel.text = (post["author"] as! PFUser).username
            
            if let timepassed = (post.createdAt) {
                timePostLabel.text = timepassed.timeAgo()
            }
            
            feedImageView.file = post["media"] as? PFFile
            self.feedImageView.loadInBackground()
            
            commentLabel.text = post["caption"] as? String
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
