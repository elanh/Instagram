//
//  DetailsViewController.swift
//  Instagram
//
//  Created by Elan Halpern on 6/29/17.
//  Copyright © 2017 Elan Halpern. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postedPhoto: UIImageView!
    
    var username: String!
    var caption: String!
    var timestamp: Date!
    var photo: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        captionLabel.text = caption
        usernameLabel.text = username
        postedPhoto.image = photo
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.long
        timestampLabel.text = dateformatter.string(from:    timestamp)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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