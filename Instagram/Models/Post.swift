//
//  File.swift
//  Instagram
//
//  Created by Ka Lee on 9/25/18.
//  Copyright © 2018 Ka Lee. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class Post: PFObject, PFSubclassing {
    
    @NSManaged var media : PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String?
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = Post()
        
        // Add relevant fields to the object
        post.media = getPFFileFromImage(image: image)!
        post.author = PFUser.current()!
        post.caption = caption!
        
        post.saveInBackground(block: completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
}

