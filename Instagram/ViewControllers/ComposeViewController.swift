//
//  ComposeViewController.swift
//  Instagram
//
//  Created by Ka Lee on 9/25/18.
//  Copyright © 2018 Ka Lee. All rights reserved.
//

import UIKit
import Photos

class ComposeViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var previewImage: UIImageView!
    
    @IBOutlet weak var captionField: UITextField!
    
    var alertController = UIAlertController()
    
    var preview: UIImage!
    
    @IBAction func shareButton(_ sender: Any) {
        Post.postUserImage(image: previewImage.image, withCaption: captionField.text, withCompletion: { (success: Bool, error: Error?) -> Void in
            if let error = error{
                if self.previewImage.image == #imageLiteral(resourceName: "image_placeholder") {
                    self.alertController = UIAlertController(title: "Error", message: "\(String(describing: error.localizedDescription))", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                        // handle cancel response here. Doing nothing will dismiss the view.
                    }
                    self.alertController.addAction(cancelAction)
                    DispatchQueue.global().async(execute: {
                        DispatchQueue.main.sync{
                            self.present(self.alertController, animated: true, completion: nil)
                        }
                    })
                }
            } else {
                self.alertController = UIAlertController(title: "Success", message: "You have shared a new post!", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
                    
                }
                self.alertController.addAction(cancelAction)
                DispatchQueue.global().async(execute: {
                    DispatchQueue.main.sync{
                        self.present(self.alertController, animated: true, completion: nil)
                    
                    }
                })
                
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewImage.image = preview
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
