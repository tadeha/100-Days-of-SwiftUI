//
//  ContentView_Day_69.swift
//  BucketList
//
//  Created by Tadeh Alexani on 5/25/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct ContentView_Day_69: View {
  
  @State private var isUnlocked = false
  
  var body: some View {
    VStack {
      if isUnlocked {
        Text("Unlocked")
      } else {
        Text("Locked")
      }
    }
    .onAppear(perform: authenticate)
    
  }
  
  func authenticate() {
    let context = LAContext()
    var error: NSError?
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "We need to unlock your data."
      
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
      // no biometrics
    }
  }
}

struct ContentView_Day_69_Previews: PreviewProvider {
  static var previews: some View {
    ContentView_Day_69()
  }
}
