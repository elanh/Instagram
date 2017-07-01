//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Elan Halpern on 6/29/17.
//  Copyright © 2017 Elan Halpern. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var usernameTitle: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var profileImageView: PFImageView!
   
    @IBOutlet weak var usernameLabel: UILabel!
    var feedPosts: [PFObject] = []
    var imagePickerController: UIImagePickerController = UIImagePickerController()
    var profilePicture: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.layer.cornerRadius = 37
        profileImageView.clipsToBounds = true
        
        if let user = PFUser.current() {
            profileImageView.file = user["profilePicture"] as? PFFile
            profileImageView.loadInBackground()
        }
       
        
        refresh()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedPosts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! photoCell
        
        let post = feedPosts[indexPath.row]
        let image = post["image"] as! PFFile
        let account = post["account"] as! PFUser
        
        usernameLabel.text = account.username
        usernameTitle.title = account.username
        
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
    
    
    @IBAction func onChangeProfPic(_ sender: Any) {
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        if let user = PFUser.current() {
            user["profilePicture"] = Post.getPFFileFromImage(image: originalImage)
        }
        profilePicture = originalImage
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
