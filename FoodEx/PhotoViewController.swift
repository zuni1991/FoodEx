//
//  PhotoViewController.swift
//  FoodEx
//
//  Created by Juan Zuniga on 4/10/20.
//  Copyright © 2020 Juan Zuniga. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse
import MapKit
import CoreLocation

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    var lat = 0.0
    var lon = 0.0
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        self.manager.requestAlwaysAuthorization()

        // For use in foreground
        self.manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
        }
    }
        
//        THIS CODE PRINTS LOCATIONS
//        WE NEED TO BE ABLE TO CALL THIS FUNCTION IN THE onSubmitButton FUNCTION
//        AND SOMEHOW STORE THE LAN AND LONG AS PFObjects.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let location = locations[0]
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        print("locations = \(location.coordinate.latitude) \(location.coordinate.longitude)")
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        post["latitude"] = lat
        post["longitude"] = lon
        
        let imageData = imageView.image!.pngData()!
        let file = PFFileObject(name: "image.png", data: imageData)
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success{
                //self.dismiss(animated: true, completion: nil)
                self.tabBarController?.selectedIndex = 0
                print("saved!")
            }else{
                print("Error!")
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
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
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
}
