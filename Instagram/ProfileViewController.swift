//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Elan Halpern on 6/29/17.
//  Copyright © 2017 Elan Halpern. All rights reserved.
//

import UIKit
import Parse


class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var usernameTitle: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var feedPosts: [PFObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedPosts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! photoCell
        
        let post = feedPosts[indexPath.row] //ppfobject
        //let caption = post["caption"] as! String //string
        let image = post["image"] as! PFFile
        let account = post["account"] as! PFUser
        
        usernameTitle.prompt = account.username
        cell.photoImageView.file = image
        cell.photoImageView.loadInBackground()
        
        return cell
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {

        let query = PFQuery(className: "Post")
        query.order(byDescending: "_created_at")
        query.whereKey("account", equalTo: PFUser.current()!)
        query.includeKey("account")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.feedPosts.removeAll()
                for post in posts {
                    self.feedPosts.append(post)
                }
                self.collectionView.reloadData()
            } else {
                print(error?.localizedDescription)
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
