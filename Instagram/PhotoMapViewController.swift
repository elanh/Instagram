//
//  PhotoMapViewController.swift
//  Instagram
//
//  Created by Elan Halpern on 6/27/17.
//  Copyright © 2017 Elan Halpern. All rights reserved.
//

import UIKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate {
    
    var chosenImage: UIImage!
    
    @IBOutlet weak var imageToPost: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tabBarController?.delegate = self
        imageToPost.image = chosenImage
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 1 {
//            loadImagePicker()
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let captionViewController = segue.destination as! CaptionViewController
        captionViewController.imageToPost = imageToPost.image
    }
    
}
