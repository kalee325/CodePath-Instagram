//
//  PostDetailViewController.swift
//  Instagram
//
//  Created by Ka Lee on 10/3/18.
//  Copyright © 2018 Ka Lee. All rights reserved.
//

import UIKit
import ParseUI

class PostDetailViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var postImage: PFImageView!
    
    @IBOutlet weak var comment: UILabel!
    
    var post: PFObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = post {
            username.text = (post["author"] as! PFUser).username
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MMM-dd"
            let postDate = dateFormatter.string(from: post.createdAt!)
            time.text = postDate
            
            postImage.file = post["media"] as? PFFile
            self.postImage.loadInBackground()
            
            comment.text = post["caption"] as! String?

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
