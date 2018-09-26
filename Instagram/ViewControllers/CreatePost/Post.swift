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
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    @NSManaged var media : PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String?
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int
    
    @NSManaged var location: String?
    var hasFavorited: Bool?
    @NSManaged var idString: String
    
    @NSManaged var postedTimeStamp: NSDate?
    
    @NSManaged var authorUsername: String
    @NSManaged var authorProfileImageFile : PFFile
    
    // for printing purpose only
    var raw_post: PFObject?
    
    func printTweetsUser() {
        print("\(String(describing: author))")
    }
    
    func printAll() {
        print("\(String(describing: raw_post))")
    }
    
    class func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // resize the image
        let newSize = CGSize(width: 200, height: 300)        
        // Create Parse object PFObject
        let post = Post()
        let resizedImage = Post.resize(image: image!, newSize: newSize)
        
        // Add relevant fields to the object
        post.media = getPFFileFromImage(image: resizedImage)! // PFFile column type
        post.author = PFUser.current()! // Pointer column type that points to PFUser
        post.caption = caption
        post.likesCount = 0
        post.commentsCount = 0
        
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

