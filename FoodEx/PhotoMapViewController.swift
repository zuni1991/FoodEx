//
//  PhotoMapViewController.swift
//  FoodEx
//
//  Created by Andrew on 4/12/20.
//  Copyright © 2020 Andrew Marmolejo. All rights reserved.
//

import UIKit
import MapKit
import Parse
import AlamofireImage

class PhotoMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var posts = [PFObject]()

    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Posts")
        query.includeKey("author")
        query.limit = 5
        
        query.findObjectsInBackground{(posts,error) in
            if posts != nil{
                self.posts = posts!
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // One degree of latitude is approximately 111 kilometers (69 miles) at all times.
        // San Francisco Lat, Long = latitude: 37.783333, longitude: -122.416667
        let mapCenter = CLLocationCoordinate2D(latitude: 36.6517, longitude: -121.7978)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
        createAnnotations(posts: posts)
        mapView.setRegion(region, animated: false)
        
    }
    
    func createAnnotations(posts : [PFObject]){
        for post in posts{
            let annotations = MKPointAnnotation()
            annotations.title = post["caption"] as? String
            annotations.coordinate = CLLocationCoordinate2D(latitude: post["latitude"] as! CLLocationDegrees, longitude: (post["longitude"] as? CLLocationDegrees)!)
            mapView.addAnnotation(annotations)
        }
    }
    

}
