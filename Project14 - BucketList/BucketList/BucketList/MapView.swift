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
  
  @Binding var centerCoordinate: CLLocationCoordinate2D
  @Binding var selectedPlace: MKPointAnnotation?
  @Binding var showingPlaceDetails: Bool
  var annotations: [MKPointAnnotation]
  
  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
      self.parent = parent
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
      parent.centerCoordinate = mapView.centerCoordinate
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      
      let identifier = "Placemark"
      
      var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
      
      if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView?.annotation = annotation
        annotationView?.canShowCallout = true
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      } else {
        annotationView?.annotation = annotation
      }
      
      return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
      guard let placemark = view.annotation as? MKPointAnnotation else {
        return
        
      }
      parent.selectedPlace = placemark
      parent.showingPlaceDetails = true
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    if uiView.annotations.count != annotations.count {
      uiView.removeAnnotations(uiView.annotations)
      uiView.addAnnotations(annotations)
    }
  }
}

extension MKPointAnnotation {
  static var example: MKPointAnnotation {
    let annotation = MKPointAnnotation()
    annotation.title = "Hannover"
    annotation.subtitle = "A beautiful city in Germany"
    annotation.coordinate = CLLocationCoordinate2D(latitude: 52.3759, longitude: 9.7320)
    return annotation
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(false), annotations: [MKPointAnnotation.example])
  }
}
