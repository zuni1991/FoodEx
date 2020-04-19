//
//  PhotoMapViewController.swift
//  FoodEx
//
//  Created by Andrew on 4/12/20.
//  Copyright © 2020 Andrew Marmolejo. All rights reserved.
//

import UIKit
import MapKit


class PhotoMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // One degree of latitude is approximately 111 kilometers (69 miles) at all times.
        // San Francisco Lat, Long = latitude: 37.783333, longitude: -122.416667
        let mapCenter = CLLocationCoordinate2D(latitude: 36.6517, longitude: -121.7978)
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: mapCenter, span: mapSpan)
        // Set animated property to true to animate the transition to the region
        mapView.setRegion(region, animated: false)
        let annotaion  = MKPointAnnotation()
//        annotaion.coordinate = CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
    }
    

    

}
