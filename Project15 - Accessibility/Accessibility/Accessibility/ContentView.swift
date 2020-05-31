//
//  ContentView.swift
//  Accessibility
//
//  Created by Tadeh Alexani on 5/31/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  let images = [
    "ales-krivec-15949",
    "galina-n-189483",
    "kevin-horstmann-141705",
    "nicolas-tissot-335096"
  ]
  
  let labels = [
    "Tulips",
    "Frozen tree buds",
    "Sunflowers",
    "Fireworks",
  ]
  
  @State private var selectedImage = Int.random(in: 0...3)
  @State private var estimate = 25.0
  @State private var rating = 3
  
  var body: some View {
    Group {
      VStack {
        Text("Your score is")
        Text("1000")
          .font(.title)
      }
      .accessibilityElement(children: .ignore)
      .accessibility(label: Text("Your score is 1000"))
      
      Image(images[selectedImage])
        .resizable()
        .scaledToFit()
        .accessibility(label: Text(labels[selectedImage]))
        .accessibility(addTraits: .isButton)
        .accessibility(removeTraits: .isImage)
        .onTapGesture {
          self.selectedImage = Int.random(in: 0...3)
      }
      
      HStack {
        Slider(value: $estimate, in: 0...50)
        .accessibility(value: Text("\(Int(estimate))"))
        Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
        .accessibility(value: Text("\(rating) out of 5"))
      }
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
