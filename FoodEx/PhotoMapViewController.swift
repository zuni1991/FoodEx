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

class PhotoMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var feed = [PFObject]()
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.add_Annotations()
        
    }
    
    func add_Annotations(){
        var annotations = [MKPointAnnotation]()
        for post in feed{
            let annotation = MKPointAnnotation()
            annotation.title = post["caption"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: post["latitude"] as! CLLocationDegrees, longitude: (post["longitude"] as? CLLocationDegrees)!)
            annotations.append(annotation)
        }
        mapView.showAnnotations(annotations,animated: true)
    }
}


