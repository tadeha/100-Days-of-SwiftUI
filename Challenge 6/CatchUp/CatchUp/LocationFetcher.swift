//
//  LocationFetcher.swift
//  CatchUp
//
//  Created by Tadeh Alexani on 6/5/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
  let manager = CLLocationManager()
  var lastKnownLocation: CLLocationCoordinate2D?
  
  override init() {
    super.init()
    manager.delegate = self
  }
  
  func start() {
    manager.requestWhenInUseAuthorization()
    manager.startUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    lastKnownLocation = locations.first?.coordinate
  }
}
