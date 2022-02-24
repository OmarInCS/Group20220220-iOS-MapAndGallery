//
//  ViewController.swift
//  MapAndGallery
//
//  Created by user on 2/24/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var locationMgr = CLLocationManager()
    var userLoc: CLLocationCoordinate2D!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let center = CLLocationCoordinate2D(latitude: 24.7933648, longitude: 46.7674239)
        let region = MKCoordinateRegion(center: center, span: span)
        map.setRegion(region, animated: true)
        
        let marker = MKPointAnnotation()
        marker.coordinate = center
        marker.title = "Atiaf Mall"
        marker.subtitle = "A nice Mall"
        
        map.addAnnotation(marker)
        
        locationMgr.desiredAccuracy = kCLLocationAccuracyBest
        locationMgr.requestWhenInUseAuthorization()
        locationMgr.startUpdatingLocation()
        locationMgr.delegate = self
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(addNewLocation(gesture:)))
        gesture.minimumPressDuration = 2
        map.addGestureRecognizer(gesture)
    }
    
    @objc func addNewLocation(gesture: UIGestureRecognizer) {
        
        let touchPoint = gesture.location(in: map)
        let mapPoint = map.convert(touchPoint, toCoordinateFrom: map)
        
        let marker = MKPointAnnotation()
        marker.coordinate = mapPoint
        marker.title = "New Location"
        
        map.addAnnotation(marker)
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        userLoc = locations.first?.coordinate
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: userLoc, span: span)
        map.setRegion(region, animated: true)
        
        map.removeAnnotations(map.annotations)
        
        let marker = MKPointAnnotation()
        marker.coordinate = userLoc
        marker.title = "User Location"
        
        map.addAnnotation(marker)
        
        
    }

}

