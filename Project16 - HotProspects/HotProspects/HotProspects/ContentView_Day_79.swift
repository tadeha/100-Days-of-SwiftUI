//
//  ContentView_Day_79.swift
//  HotProspects
//
//  Created by Tadeh Alexani on 6/5/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
  @Published var name = "Tadeh Alexani"
}

struct EditView: View {
  
  @EnvironmentObject var user: User
  
  var body: some View {
    TextField("Name", text: $user.name)
    .padding()
  }
  
}

struct DisplayView: View {
  
  @EnvironmentObject var user: User
  
  var body: some View {
    Text(user.name)
  }
  
}

struct ContentView_Day_79: View {
  
  @State private var selectedTab = 0
  let user = User()
  
  var body: some View {
    TabView(selection: $selectedTab) {
      EditView()
      .tabItem {
        Image(systemName: "star")
        Text("One")
      }
      .tag(0)
      
      DisplayView()
        .tabItem {
          Image(systemName: "star.fill")
          Text("Two")
      }
      .tag(1)
    }
    .environmentObject(user)
    
  }
}

struct ContentView_Day_79_Previews: PreviewProvider {
  static var previews: some View {
    ContentView_Day_79()
  }
}
