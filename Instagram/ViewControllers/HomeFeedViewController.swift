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

class HomeFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var posts : [Post] = []
    var raw_posts: [PFObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 200
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeFeedCell", for: indexPath) as! HomeFeedCell
        cell.post = self.raw_posts[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.raw_posts.count
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let user = PFUser.current() ?? nil
                print("Successful logout")
                print(user as Any)
                
                self.performSegue(withIdentifier: "logoutSegue", sender: nil)

            }
            
        })
    }
    
    func getData(completion: @escaping (_ success: Bool, _ error: Error?) -> Void) -> Void {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                print("Posts are: ", posts)
                // do something with the data fetched
                self.raw_posts = posts
                completion(true, nil)
                
            } else {
                print("Error! : ", error?.localizedDescription ?? "No localized description for error")
                // handle error
                completion(false, error)
            }
            self.tableView.reloadData()
        }
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
