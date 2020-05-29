//
//  ContentView.swift
//  BucketList
//
//  Created by Tadeh Alexani on 5/25/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
  
  let savedPlaces = "SavedPlaces"
  
  @State private var centerCoordinate = CLLocationCoordinate2D()
  @State private var selectedPlace: MKPointAnnotation?
  @State private var showingPlaceDetails = false
  @State private var locations = [CodableMKPointAnnotaiton]()
  @State private var showingEditView = false
  @State private var isUnlocked = false
  
  var body: some View {
    ZStack {
      if isUnlocked {
        MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
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
              let location = CodableMKPointAnnotaiton()
              location.title = "Example"
              location.coordinate = self.centerCoordinate
              self.locations.append(location)
              
              self.selectedPlace = location
              self.showingEditView = true
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
      } else {
        Button("Unlock Places") {
          self.authenticate()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
      }
    }
    .alert(isPresented: $showingPlaceDetails) {
      Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
        self.showingEditView = true
        })
    }
    .sheet(isPresented: $showingEditView, onDismiss: saveData) {
      if self.selectedPlace != nil {
        EditView(placemark: self.selectedPlace!)
      }
    }
    .onAppear(perform: loadData)
  }
  
  func loadData() {
    let fm = FileManager()
    let fileName = fm.getDocumentsDirectory().appendingPathComponent(savedPlaces)
    
    do {
      let data = try Data(contentsOf: fileName)
      locations = try JSONDecoder().decode([CodableMKPointAnnotaiton].self, from: data)
    } catch {
      print("Unable to load data.")
    }
  }
  
  func saveData() {
    
    do {
      let fm = FileManager()
      let fileName = fm.getDocumentsDirectory().appendingPathComponent(savedPlaces)
      let data = try JSONEncoder().encode(self.locations)
      try data.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
    } catch {
      print("Unable to save data.")
    }
  }
  
  func authenticate() {
    let context = LAContext()
    var error: NSError?
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "Please authenticate yourself to unlock your places."
      
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
        
        DispatchQueue.main.async {
          if success {
            self.isUnlocked = true
          } else {
            // there was a problem
          }
        }
      }
    } else {
      // no biometry
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
