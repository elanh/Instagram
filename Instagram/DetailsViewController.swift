//
//  DetailsViewController.swift
//  Instagram
//
//  Created by Elan Halpern on 6/29/17.
//  Copyright © 2017 Elan Halpern. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailsViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postedPhoto: PFImageView!
    
    var post: PFObject!
    var timestamp: Date!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.long
        timestampLabel.text = dateformatter.string(from:    timestamp)
        
        captionLabel.text = post["caption"] as! String
        let user = post["account"] as! PFUser
        usernameLabel.text = user.username
        postedPhoto.file = post["image"] as! PFFile
        
        
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
