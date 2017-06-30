//
//  PhotoMapViewController.swift
//  Instagram
//
//  Created by Elan Halpern on 6/27/17.
//  Copyright © 2017 Elan Halpern. All rights reserved.
//

import UIKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate {
    
    var isFromCamera = false
    var chosenImage: UIImage!
    var imagePickerController: UIImagePickerController = UIImagePickerController()
    
    @IBOutlet weak var imageToPost: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(isFromCamera)
        if(!isFromCamera) {
            loadImagePicker()
        } else {
            isFromCamera = false
        }
        
        tabBarController?.delegate = self
        imageToPost.image = chosenImage
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 1 {
            isFromCamera = false
            loadImagePicker()
        }
    }
    
    func loadImagePicker() {
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageToPost.image = originalImage
        dismiss(animated: true, completion: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let captionViewController = segue.destination as! CaptionViewController
        captionViewController.imageToPost = imageToPost.image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
