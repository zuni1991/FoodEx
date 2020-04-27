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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = profilePic.bounds.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
           let user = PFUser.current()
        userName.text = user?.username
        let query = PFQuery(className: "ProfilePic")
        query.whereKey("author", equalTo: PFUser.current()!)
        query.findObjectsInBackground(block: {(object,error)->Void in
            if object != nil && error != nil{
                let ImageFile = object?[0]["image"] as! PFFileObject
                let urlString = ImageFile.url!
                let url = URL(string: urlString)!
                self.profilePic.af_setImage(withURL: url)
                print("Profile picture Loaded")
            }
        })
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        profilePic.image = scaledImage
        
        //Parse Object creation to add user profile pic to class ProfilePic
        let imageToBeSet = PFObject(className: "ProfilePic")
        let imageData = profilePic.image!.pngData()!
        let file = PFFileObject(name: "image.png", data: imageData)
        imageToBeSet["image"] = file
        imageToBeSet["author"] = PFUser.current()!
        imageToBeSet.saveInBackground { (success, error) in
            if success{
                print("New profile picture saved!")
            }else{
                print("Error!")
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
