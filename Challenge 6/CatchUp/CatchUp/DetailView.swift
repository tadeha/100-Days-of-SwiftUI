//
//  DetailView.swift
//  CatchUp
//
//  Created by Tadeh Alexani on 6/5/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import MapKit

struct DetailView: View {
  
  var codableImage: CodableImage
  
  var body: some View {
    VStack(spacing: 0) {

      if UIImage(data: codableImage.jpegData) != nil {
        Image(uiImage: UIImage(data: codableImage.jpegData)!)
          .resizable()
          .scaledToFit()
      }
      
      MapView(centerCoordinate: .constant(codableImage.coordinate), selectedPlace: .constant(MKPointAnnotation.example), showingPlaceDetails: .constant(false), annotations: [makeAnnotation(from: codableImage)])
        .edgesIgnoringSafeArea(.all)
      
    }
    .navigationBarTitle(Text(codableImage.name), displayMode: .inline)
  }
  
  func makeAnnotation(from codableImage: CodableImage) -> MKPointAnnotation {
    let annotation = MKPointAnnotation()
    annotation.title = codableImage.name
    annotation.coordinate = codableImage.coordinate
    return annotation
  }
}
