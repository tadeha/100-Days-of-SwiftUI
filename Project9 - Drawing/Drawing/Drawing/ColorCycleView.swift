//
//  ColorCycleView.swift
//  Drawing
//
//  Created by Tadeh Alexani on 5/2/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct ColorCyclingCircle: View {
  var amount = 0.0
  var steps = 100
  
  var body: some View {
    ZStack {
      ForEach(0..<steps) { value in
        Circle()
          .inset(by: CGFloat(value))
          .strokeBorder(LinearGradient(gradient: Gradient(colors: [
              self.color(for: value, brightness: 1),
              self.color(for: value, brightness: 0.5)
          ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
      }
      .drawingGroup()
    }
  }
  
  func color(for value: Int, brightness: Double) -> Color {
    var targetHue = Double(value) / Double(self.steps) + self.amount
    
    if targetHue > 1 {
      targetHue -= 1
    }
    
    return Color(hue: targetHue, saturation: 1, brightness: brightness)
  }
}

struct ColorCycleView: View {
  @State private var colorCycle = 0.0
  
  var body: some View {
    VStack {
      ColorCyclingCircle(amount: self.colorCycle)
        .frame(width: 300, height: 300)
      
      Slider(value: $colorCycle)
    }
  }
}

struct ColorCycleView_Previews: PreviewProvider {
  static var previews: some View {
    ColorCycleView()
  }
}
