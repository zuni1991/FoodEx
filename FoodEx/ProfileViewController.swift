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

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = profilePic.bounds.width / 2
        
        let query = PFQuery(className: "_User")
        query.findObjectsInBackground { (object, error) in
            if error == nil{
                if let returnedObjects = object{
                    for object in returnedObjects{
                        let currentUser = PFUser.current()
                        let name = currentUser!["name"] as? String
                        let firstCapitalized = String(name!).capitalized
                        self.userName.text  = firstCapitalized
                        let location = currentUser!["location"] as? String
                        let locationCapitalized = String(location!).uppercased()
                        self.locationLabel.text = locationCapitalized
                        let email = currentUser!["email"] as? String
                        self.emailLabel.text = email
                    }
                }
            }
        }
       let profileQuery = PFQuery(className: "ProfilePic")
        let user = PFUser.current()!
        profileQuery.whereKey("author", equalTo:user)
        profileQuery.findObjectsInBackground { (objects, error) in
              if error == nil{
                if let returnedObjects = objects{
                    for objects in returnedObjects{
                       let user = PFUser.current()!
                       profileQuery.whereKey("author", equalTo:user)
                       let ImageFile = objects["image"] as! PFFileObject
                       let urlString = ImageFile.url!
                       let url = URL(string: urlString)!
                      self.profilePic.af_setImage(withURL: url)
                    }
                    
                }
                
            
        }
    }
    }


    @IBAction func uploadPic(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
        
    }
    
}
    



