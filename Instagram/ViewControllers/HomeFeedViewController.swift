//
//  HomeFeedViewController.swift
//  Instagram
//
//  Created by Ka Lee on 9/21/18.
//  Copyright © 2018 Ka Lee. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var posts : [PFObject] = []
    var refreshControl: UIRefreshControl!
    var photo: UIImage?
    
    @IBAction func cameraButton(_ sender: Any) {
        let imageVC = UIImagePickerController()
        imageVC.delegate = self
        imageVC.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            imageVC.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            imageVC.sourceType = .photoLibrary
        }
        self.present(imageVC, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let previewImage = info[UIImagePickerControllerEditedImage] as! UIImage?
        photo = previewImage
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "tagSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "tagSegue" {
            let vc: ComposeViewController = segue.destination as! ComposeViewController
            vc.preview = photo
        } else if segue.identifier == "detailSegue" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell){
                let post = posts[indexPath.row]
                let detailViewController = segue.destination as! PostDetailViewController
                detailViewController.post = post
            }
            
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeFeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        
        postFetch()
    }
    
    @objc func didPullToRefresh(_ refreshControll: UIRefreshControl){
        postFetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeFeedCell", for: indexPath) as! HomeFeedCell
        cell.post = posts[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func postFetch(){
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                print("Posts are: ", posts)
                // do something with the data fetched
                self.posts = posts
                
            } else {
                print("Error! : ", error?.localizedDescription ?? "No localized description for error")
            }
            self.tableView.reloadData()
        }
        self.refreshControl.endRefreshing()
    }
    

}
