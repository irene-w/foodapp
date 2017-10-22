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
    
    var latitude: String!
    var longitude: String!
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
        
        // Add the map to the view, hide it until we've got a location update.
        
        view.addSubview(mapView)
        mapView.isHidden = true
        //mapView.frame.size.height = mapView.frame.size.height - 20
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.clear()
        for tasteBud in BackEnd.tasteBuds {
            createMarkers(tasteBud)
        }
    }
    
    func createMarkers(_ tasteBud: TasteBud) {
        setLatitudeLongitude(tasteBud.info["Location"]!)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
        marker.title = tasteBud.info["Name"]
        marker.snippet = tasteBud.info["Restaurant"]!
        marker.map = mapView
    }
    
    func setLatitudeLongitude(_ location: String) {
        var indexOfComma = location.startIndex
        while (indexOfComma != location.endIndex) {
            if location[indexOfComma] == "," {break}
            indexOfComma = location.index(after: indexOfComma)
        }
        latitude = location.substring(to: location.index(before: indexOfComma))
        longitude = location.substring(from: location.index(after: indexOfComma))
    }

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
