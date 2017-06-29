//
//  PickerViewController.swift
//  Instagram
//
//  Created by Elan Halpern on 6/28/17.
//  Copyright © 2017 Elan Halpern. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePickerController: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is avaliable 📸")
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapLibrary(_ sender: Any) {
        loadImagePicker()
    }
    
    
    func loadImagePicker() {
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
        //        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        //            print("Camera is avaliable 📸")
        //            imagePickerController.sourceType = .camera
        //            self.present(imagePickerController, animated: true, completion: nil)
        //        } else {
        //            print("Camera 🚫 available so we will use photo library instead")
        //            imagePickerController.sourceType = .photoLibrary
        //            self.present(imagePickerController, animated: true, completion: nil)
        //        }
    }
    
    var chosenImage: UIImage!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        dismiss(animated: true, completion: nil)
        
        performSegue(withIdentifier: "PickerSegue", sender: nil)
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
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "PickerSegue" {
            let destVC = segue.destination as! PhotoMapViewController
            
            destVC.chosenImage = chosenImage
        }
        
    }
    
    
}
