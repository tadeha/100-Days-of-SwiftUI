//
//  FlowerView.swift
//  Drawing
//
//  Created by Tadeh Alexani on 5/2/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct Flower: Shape {
  var petalOffset: Double = -20
  var petalWidth: Double = 100
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
      
      let rotation = CGAffineTransform(rotationAngle: number)
      
      let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
      
      let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
      
      let rotatedPetal = originalPetal.applying(position)
      
      path.addPath(rotatedPetal)
    }
    
    return path
    
  }
}

struct FlowerView: View {
  @State private var petalOffset = -20.0
  @State private var petalWidth = 100.0
  
  var body: some View {
    VStack {
      Flower(petalOffset: petalOffset, petalWidth: petalWidth)
        .fill(Color.pink, style: FillStyle(eoFill: true))
      
      Text("Offset")
      Slider(value: $petalOffset, in: -40...40)
        .padding([.horizontal, .bottom])
      
      Text("Width")
      Slider(value: $petalWidth, in: 0...100)
        .padding(.horizontal)
    }
  }
}

struct FlowerView_Previews: PreviewProvider {
  static var previews: some View {
    FlowerView()
  }
}
