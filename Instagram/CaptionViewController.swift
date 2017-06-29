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
    
    var imageToPost: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newImage = resize(image: imageToPost, newSize: CGSize(width: 640, height: 640))
        photoToPost.image = newImage
    }
    
    @IBAction func onPost(_ sender: Any) {
        Post.postUserImage(image: photoToPost.image, withCaption: captionTextField.text) { (success: Bool, error: Error?) in
            print("Image posted.")
        }
        
        //Return to feed page after the user makes a post
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.tabBarController.selectedIndex = 0
        dismiss(animated: true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
