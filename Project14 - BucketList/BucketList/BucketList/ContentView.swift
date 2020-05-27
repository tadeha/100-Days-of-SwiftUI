//
//  ContentView.swift
//  BucketList
//
//  Created by Tadeh Alexani on 5/25/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
  
  @State private var centerCoordinate = CLLocationCoordinate2D()
  @State private var selectedPlace: MKPointAnnotation?
  @State private var showingPlaceDetails = false
  @State private var locactions = [MKPointAnnotation]()
  
  var body: some View {
    ZStack {
      MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locactions)
        .edgesIgnoringSafeArea(.all)
      
      Circle()
        .fill(Color.blue)
        .opacity(0.3)
        .frame(width: 32, height: 32)
      
      VStack {
        Spacer()
        HStack {
          Spacer()
          Button(action: {
            let location = MKPointAnnotation()
            location.title = "Example"
            location.coordinate = self.centerCoordinate
            self.locactions.append(location)
          }) {
            Image(systemName: "plus")
          }
          .padding()
          .background(Color.black.opacity(0.75))
          .foregroundColor(.white)
          .font(.title)
          .clipShape(Circle())
          .padding(.trailing)
        }
      }
    }
    .alert(isPresented: $showingPlaceDetails) {
      Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
        // edit this place
        })
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
