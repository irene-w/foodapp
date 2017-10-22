//
//  GetLocation.swift
//  TasteBuds
//
//  Created by Dewayne Perry on 10/22/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class GetLocation: UIViewController,  CLLocationManagerDelegate {
    var manager = CLLocationManager()
    var latLog: String?
    var delegate: LocationDelegate!
    var locationManagerWasCalled = false
    
    func work(delegate: LocationDelegate) {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        self.delegate = delegate
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locationManagerWasCalled == false else { return }
        locationManagerWasCalled = true
        let location = locations[0]
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        latLog = String(describing: latitude) + "," + String(describing: longitude)
        manager.stopUpdatingLocation()
        delegate.LocationObtained(latLog!)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
