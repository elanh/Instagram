//
//  CaptionViewController.swift
//  Instagram
//
//  Created by Elan Halpern on 6/27/17.
//  Copyright © 2017 Elan Halpern. All rights reserved.
//

import UIKit

class CaptionViewController: UIViewController {

    @IBOutlet weak var captionTextField: UITextField!
    
    @IBOutlet weak var photoToPost: UIImageView!
    
    var imageToPost = UIImage(named: "imageName")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoToPost.image = imageToPost
    }
    
    @IBAction func onPost(_ sender: Any) {
        Post.postUserImage(image: photoToPost.image, withCaption: captionTextField.text) { (success: Bool, error: Error?) in
            print("Image posted.")
            self.imageToPost = UIImage(named: "imageName")
            self.captionTextField.text = ""
        }
        
        //Return to feed page after the user makes a post
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.tabBarController.selectedIndex = 0
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
