//
//  ProfileViewController.swift
//  FoodEx
//
//  Created by Juan Zuniga on 4/17/20.
//  Copyright © 2020 Juan Zuniga. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class ProfileViewController: UIViewController{
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    var profile = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = profilePic.bounds.width / 2
    }
}
    



