//
//  ContentView_Day_96.swift
//  SnowSeeker
//
//  Created by Tadeh Alexani on 6/26/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI


struct UserView: View {
  var body: some View {
    Group {
      Text("Tadeh")
      Text("Alexani")
      Text("At Real Madrid you win the finals!")
    }
  }
}

struct ContentView_Day_96: View {
  
  @Environment(\.horizontalSizeClass) var sizeClass
  
  var body: some View {
    Group {
      if sizeClass == .compact {
        VStack(content: UserView.init)
      } else {
        HStack(content: UserView.init)
      }
    }
  }
}

struct ContentView_Day_96_Previews: PreviewProvider {
  static var previews: some View {
    ContentView_Day_96()
  }
}
