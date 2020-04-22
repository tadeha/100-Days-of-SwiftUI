//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Tadeh Alexani on 4/9/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

// 1
// The some keyword in some View signals an opaque return type.
// This lets us send back some sort of view without need to say exactly which one.

// 2
// Local modifiers always override environment modifiers from the parent.

// 3
// Custom view modifiers must conform to the ViewModifier protocol.
// This has one requirement: a body() method that returns some View.

// 4
// SwiftUI lets us create our own custom view modifiers.
// This can help keep our code free of redundancy.
//
// View composition refers to making music with views.
// View composition refers to combining smaller views into bigger ones.

import SwiftUI

struct LargeBlueView: ViewModifier {
  
  func body(content: Content) -> some View {
    content
    .font(.largeTitle)
    .foregroundColor(.blue)
      
  }
  
}

extension View {
  func makeViewLargeAndBlue() -> some View {
    self.modifier(LargeBlueView())
  }
}

struct ContentView: View {
  var body: some View {
    ZStack() {
      Color.yellow.edgesIgnoringSafeArea(.all)
      Text("Test")
    }
    .makeViewLargeAndBlue()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
