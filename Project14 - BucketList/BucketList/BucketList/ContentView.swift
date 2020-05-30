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
  
  @State private var isUnlocked = false
  @State private var showingAuthenticationError = false
  @State private var authenticationErrorMessage = ""
  
  var body: some View {
    ZStack {
      if isUnlocked {
        UnlockedMapView()
      } else {
        Button("Unlock Places") {
          self.authenticate()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
        .alert(isPresented: $showingAuthenticationError) {
          Alert(title: Text("Error Occured"), message: Text(self.authenticationErrorMessage), dismissButton: .default(Text("OK")))
        }
      }
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
            self.authenticationErrorMessage = authenticationError?.localizedDescription ?? "Unknown error happened. Please try again."
            self.showingAuthenticationError = true
          }
        }
      }
    } else {
      self.authenticationErrorMessage = "Biometrics authentication is not available."
      self.showingAuthenticationError = true
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
