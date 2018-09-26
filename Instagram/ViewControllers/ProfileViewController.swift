//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Ka Lee on 9/25/18.
//  Copyright © 2018 Ka Lee. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = PFUser.current()?.username

    }

    @IBAction func userLogout(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let user = PFUser.current() ?? nil
                print("Successful logout")
                print(user as Any)
                
                self.performSegue(withIdentifier: "toHomeSegue", sender: nil)
                
            }
        })
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
