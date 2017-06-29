//
//  PhotoMapViewController.swift
//  Instagram
//
//  Created by Elan Halpern on 6/27/17.
//  Copyright © 2017 Elan Halpern. All rights reserved.
//

import UIKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageToPost: UIImageView!
    var imagePickerController: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        loadImagePicker()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if imageToPost.image == UIImage(named: "imageName") {
            print("we shoudl load image picker now")
            loadImagePicker()
        }
        
    }
    
    func loadImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is avaliable 📸")
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let origionalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageToPost.image = origionalImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.tabBarController.selectedIndex = 0
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is avaliable 📸")
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
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
