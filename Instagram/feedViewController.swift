//
//  feedViewController.swift
//  Instagram
//
//  Created by Elan Halpern on 6/27/17.
//  Copyright © 2017 Elan Halpern. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class feedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var feedPosts: [PFObject] = []
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.dataSource = self
        feedTableView.delegate = self
        
        let query = PFQuery(className: "Post")
       //query.order(byDescending: "_createdAt_")
        query.includeKey("account")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the array of object returned by the call
                for post in posts {
                    self.feedPosts.append(post)
                }
                //print(self.feedPosts)
                self.feedTableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let post = feedPosts[indexPath.row] //ppfobject
        let caption = post["caption"] as! String //string
        let image = post["image"] as! PFFile
        let account = post["account"] as! PFUser
        

        cell.userNameLabel.text = account.username
        cell.captionLabel.text = caption
        cell.postImage.file = image
        cell.postImage.loadInBackground()
        
        return cell
    }

    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground{ (error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.dismiss(animated: true, completion: nil)
                print("Logout sucessful.")
            }
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
