//
//  RGBBlendView.swift
//  Drawing
//
//  Created by Tadeh Alexani on 5/4/20.
//  Copyright © 2020 Alexani. All rights reserved.
//

import SwiftUI

struct RGBBlendView: View {
  @State private var amount: CGFloat = 0.0
  
  var body: some View {
    VStack {
      ZStack {
        Circle()
          .fill(Color.red)
          .frame(width: 200 * amount)
          .offset(x: -50, y: -80)
          .blendMode(.screen)
        
        Circle()
          .fill(Color.green)
          .frame(width: 200 * amount)
          .offset(x: 50, y: -80)
          .blendMode(.screen)
        
        Circle()
          .fill(Color.blue)
          .frame(width: 200 * amount)
          .blendMode(.screen)
        
      }
      .frame(width: 300, height: 300)
      
      Slider(value: $amount)
        .padding()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black)
    .edgesIgnoringSafeArea(.all)
  }
}

struct RGBBlendView_Previews: PreviewProvider {
  static var previews: some View {
    RGBBlendView()
  }
}
