//
//  ContentView.swift
//  BucketList
//
//  Created by Tadeh Alexani on 5/25/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
  var body: some View {
    Text("Loading")
  }
}

struct SuccessView: View {
  var body: some View {
    Text("Success!")
  }
}

struct FailedView: View {
  var body: some View {
    Text("Failed.")
  }
}

struct User: Identifiable, Comparable {
  let id = UUID()
  let firstName: String
  let lastName: String
  
  static func < (lhs: User, rhs: User) -> Bool {
    lhs.lastName < rhs.lastName
  }
}

enum LoadingStates {
  case loading, success, failed
}

struct ContentView: View {
  
  let users = [
    User(firstName: "Arnold", lastName: "Rimmer"),
    User(firstName: "Kristine", lastName: "Kochanski"),
    User(firstName: "David", lastName: "Lister"),
  ]
  
  var loadingState: LoadingStates = .loading
  
  @State private var buttonTitle = "Tap Me"
  
  var body: some View {
    VStack {
      List(users) { user in
        Text("\(user.lastName), \(user.firstName)")
      }
      Button(buttonTitle) {
        let fileManager = FileManager()
        fileManager.save("Test String", withName: "test.txt")
        self.buttonTitle = fileManager.load(withName: "test.txt")!
      }
      if loadingState == .loading {
        LoadingView()
      } else if loadingState == .success {
        SuccessView()
      } else {
        FailedView()
      }
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
