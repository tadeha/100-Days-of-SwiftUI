//
//  ContentView.swift
//  Drawing
//
//  Created by Tadeh Alexani on 5/1/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

// The even-odd fill rule fills overlapping lines in different ways depending on how many overlaps there are.

import SwiftUI

struct ContentView: View {
  @State private var arrowThickness: CGFloat = 10
  
  var body: some View {
    VStack(spacing: 40) {
      Arrow()
        .stroke(Color.yellow, style: StrokeStyle(lineWidth: arrowThickness, lineCap: .round, lineJoin: .round))
        .frame(width: 200, height: 400)
      
        .onTapGesture {
          withAnimation {
            self.arrowThickness = CGFloat.random(in: 1...20)
          }
      }
      
      Slider(value: $arrowThickness, in: 1...50)
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
