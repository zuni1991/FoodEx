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

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    @IBOutlet weak var tableView: UITableView!
    var profilePicture = [PFObject]()
    var profileInfo = [PFObject]()


}
