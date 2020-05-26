//
//  MapView.swift
//  BucketList
//
//  Created by Tadeh Alexani on 5/26/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  
  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
      self.parent = parent
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
      print(mapView.centerCoordinate)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
      view.canShowCallout = true
      return view
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    
    let annotation = MKPointAnnotation()
    annotation.title = "Hannover"
    annotation.subtitle = "A beautiful city in Germany"
    annotation.coordinate = CLLocationCoordinate2D(latitude: 52.3759, longitude: 9.7320)
    
    mapView.addAnnotation(annotation)
    
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    
  }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
