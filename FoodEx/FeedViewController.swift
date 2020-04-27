//
//  FeedViewController.swift
//  FoodEx
//
//  Created by Andrew on 3/16/20.
//  Copyright © 2020 Juan Zuniga. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import CoreLocation
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate{

    @IBOutlet weak var tableView: UITableView!

    var posts = [PFObject]()
    var map_object = [String:[Double]]()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        checkLocationServices()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Posts")
        query.includeKey("author")
        query.limit = 10
        query.findObjectsInBackground{(posts,error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let  post = posts[indexPath.row]
        let ImageFile = post["image"] as! PFFileObject
        //let user = post["user"]
        let user = PFUser.current()?.objectId
        //let date = post["createdAt"]
        
        cell.postTimeLabel.text = "Posted by \(user ?? "User"), "
        let urlString = ImageFile.url!
        let url = URL(string: urlString)!
        cell.captionLabel.text = post["caption"] as? String
        cell.photoView.af_setImage(withURL: url)
        cell.photoView.layer.masksToBounds = true
        cell.photoView.layer.cornerRadius = 20
        return cell

    }
    
    // Location permissions Implementation
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
            let alert = UIAlertController(title: "Please Enable Location", message:"Location is required to make fully utilize this App" , preferredStyle: UIAlertController.Style.alert)
            let action1 = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                     alert.addAction(action1)
            self.present(alert, animated: true, completion: nil);
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        @unknown default:
            fatalError()
        }
    }
    
    @IBAction func Itinerario(sender: UITapGestureRecognizer) {
        //if you need the cell or index path
        let location = sender.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: location)
        if indexPath != nil
        {
          let a = "Ashish"
            print("Ashish")
          let b: String = "\n"
          let c: String = "\n"
          let d: String = "*Lugar Destacado"
          let sum = a + b + c + d

          let alert = UIAlertController(title: "Itinerario de Procesión", message: "\(sum)", preferredStyle: UIAlertController.Style.alert)
          let action1 = UIAlertAction(title: "Atrás", style: UIAlertAction.Style.cancel, handler: nil)

          alert.addAction(action1)


            self.present(alert, animated: true, completion: nil);
        }
    }
    
    // MARK: - Navigation
     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController,
            let vc = nav.topViewController as? PhotoMapViewController {
            vc.feed = posts
        }
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
         dismiss(animated: true, completion: nil)
        //self.performSegue(withIdentifier: "LoggingOut", sender: nil)
    }
}
 
