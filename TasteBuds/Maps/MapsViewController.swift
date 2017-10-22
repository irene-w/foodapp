//
//  MapsViewController.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/20/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import UIKit
import GoogleMaps

class MapsViewController: NavBarExtension {
    
    var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.edgesForExtendedLayout = []
        
        configureNavBar()
        
        // Setup the map
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: 1.285,
                                              longitude: 103.843,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        addMarker(title: "Shake Shack", iconName: "Icon Map 1", latitude: 42.3700435, longitude: -71.11643240000001)
        addMarker(title: "Tasty Burger", iconName: "Icon Map 2", latitude: 42.3725821, longitude: -71.1198316)
        addMarker(title: "Tatte bakery", iconName: "Icon Map 3", latitude: 42.3726897, longitude: -71.11694369999998)
        addMarker(title: "Cafe Sushi", iconName: "Icon Map 4", latitude: 42.3707266, longitude: -71.1133979)
        addMarker(title: "Flour Bakery", iconName: "Icon Map 5", latitude: 42.3609453, longitude: -71.09666090000002)
        
        // Add the map to the view, hide it until we've got a location update.
        
        view.addSubview(mapView)
        
        
        mapView.isHidden = true
        //mapView.frame.size.height = mapView.frame.size.height - 20
    }
    
    func addMarker(title: String, iconName: String, latitude: Double, longitude: Double) {
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: position)
        marker.title = title
        marker.icon = UIImage(named: iconName)
        marker.map = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension MapsViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
