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

class feedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    var imagePickerController: UIImagePickerController = UIImagePickerController()
    var feedPosts: [PFObject] = []
    @IBOutlet weak var feedTableView: UITableView!
    var refreshControl: UIRefreshControl!
    var choosenImage: UIImage!
    var username: String!
    var captionText: String!
    var datePosted: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.dataSource = self
        feedTableView.delegate = self
        refresh()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_refreshControl:)), for: UIControlEvents.valueChanged)
        
        feedTableView.insertSubview(refreshControl, at: 0)
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view should refresh now")
        refresh()
    }
    
    func refresh() {
        let query = PFQuery(className: "Post")
        //query.limit = 20
        query.order(byDescending: "_created_at")
        query.includeKey("account")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the array of object returned by the call
                self.feedPosts.removeAll()
                for post in posts {
                    self.feedPosts.append(post)
                }
                //print(self.feedPosts)
                self.feedTableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                print(error?.localizedDescription)
            }

        }
        print("refreshing")
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
        
        
        username = account.username
        captionText = caption
        datePosted = post.createdAt
        
        cell.userNameLabel.text = account.username
        cell.captionLabel.text = caption
        cell.postImage.file = image
        cell.postImage.loadInBackground()
        
        return cell
    }

    
    @IBAction func onLogout(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.loggedOut()
        
    }
    
    @IBAction func onCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is avaliable 📸")
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    //TODO: PERFORM SEGUE ONCE "CHOOSE" IS CLICKED
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        choosenImage = originalImage
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "cameraSegue", sender: nil)
    }
    
    func refreshControlAction(_refreshControl: UIRefreshControl) {
        refresh()
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "cameraSegue") {
            let photoMapViewController = segue.destination as! PhotoMapViewController
            photoMapViewController.chosenImage = choosenImage
            photoMapViewController.isFromCamera = true
        } else if (segue.identifier == "detailsSegue") {
            let detailsViewController = segue.destination as! DetailsViewController
            print("chaning to details view")
            detailsViewController.photo = choosenImage
            detailsViewController.caption = captionText
            detailsViewController.username = username
            detailsViewController.timestamp = datePosted
        }
        
    }
    
}
